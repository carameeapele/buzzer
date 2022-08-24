import 'package:buzzer/main.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EventsList extends ConsumerStatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventsListState();
}

class _EventsListState extends ConsumerState<EventsList> {
  final AuthService _auth = AuthService();

  void addExam(Exam exam) {
    ref.read(examsProvider.notifier).state.add(exam);
    DatabaseService(uid: _auth.toString()).addExam(exam);
  }

  void deleteExam(Exam exam) {
    ref.read(examsProvider.notifier).state.remove(exam);
    DatabaseService(uid: _auth.toString()).deleteExam(exam.id);
  }

  void editExam(Exam exam) {}

  @override
  Widget build(BuildContext context) {
    Widget defaultScreen = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.liquor,
            size: 50.0,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 5.0),
          Text(
            'Click + to add a task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.grey[300],
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );

    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    final exams = ref.watch(examsFetchProvider);

    return Container(
      child: exams.when(
        data: (List<Exam> exams) {
          return exams.isEmpty
              ? defaultScreen
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: exams.length,
                  itemBuilder: (BuildContext context, int index) {
                    Exam exam = exams[index];

                    return Card(
                      elevation: 0.0,
                      color: BuzzerColors.lightGrey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      child: Theme(
                        data: data,
                        child: ExpansionTile(
                          tilePadding:
                              const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                          title: title(exam.title, exam.tag, exam.date),
                          trailing: trailing(exam.date),
                          childrenPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 0.0,
                          ),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          expandedAlignment: Alignment.centerLeft,
                          children: <Widget>[
                            exam.notes.isNotEmpty
                                ? Text(exam.notes)
                                : const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      editExam(exam);
                                    });
                                  },
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      deleteExam(exam);
                                    });
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
        error: (Object error, StackTrace? stackTrace) {
          return Column();
        },
        loading: () {
          return const Loading();
        },
      ),
    );
  }

  RichText title(
    String title,
    String tag,
    Timestamp date,
  ) {
    return RichText(
      text: TextSpan(
        text: tag,
        style: TextStyle(
          color: date.toDate().isAfter(DateTime.now())
              ? Colors.black
              : BuzzerColors.grey,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
          decoration: date.toDate().isAfter(DateTime.now())
              ? null
              : TextDecoration.lineThrough,
          decorationThickness: 2.0,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' $title',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Text trailing(Timestamp date) {
    return Text(
      '${DateFormat('dd.MM', 'en_US').format(date.toDate())}  ',
      style: TextStyle(
        color: date.toDate().isAfter(DateTime.now())
            ? Colors.black
            : BuzzerColors.grey,
        fontSize: 16.0,
      ),
    );
  }
}
