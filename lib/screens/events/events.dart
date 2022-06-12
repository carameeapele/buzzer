import 'package:buzzer/main.dart';
import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/services/providers.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// class EventsScreen extends ConsumerStatefulWidget {
//   const EventsScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _EventsScreenState();
// }

// class _EventsScreenState extends ConsumerState<EventsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final AuthService _auth = AuthService();

//     return Container();
//   }
// }

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    ref.read(examsFetchProvider);
  }

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
    final examsList = ref.watch(examsFetchProvider);

    return Container(
      child: examsList.when(
        data: (List<Exam> exams) {
          return Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: false,
            appBar: AppBarWidget(
              title: 'Events',
              addFunction: () {},
            ),
            drawer: const MenuDrawer(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Exams',
                      style: subtitleTextStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: exams.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (exams.isEmpty) {
                          return Container();
                        }

                        Exam exam = exams[index];
                        return Card(
                          elevation: 0.0,
                          color: BuzzerColors.lightGrey,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: ExpansionTile(
                            title: RichText(
                              text: TextSpan(
                                text: exam.tag,
                                style: TextStyle(
                                  color:
                                      exam.date.toDate().isAfter(DateTime.now())
                                          ? Colors.black
                                          : BuzzerColors.grey,
                                  fontSize: 17.0,
                                  fontStyle: FontStyle.italic,
                                  decoration:
                                      exam.date.toDate().isAfter(DateTime.now())
                                          ? null
                                          : TextDecoration.lineThrough,
                                  decorationThickness: 2.0,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${exam.title}',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Text(
                              '${DateFormat('dd.MM', 'en_US').format(exam.date.toDate())}  ',
                              style: TextStyle(
                                color:
                                    exam.date.toDate().isAfter(DateTime.now())
                                        ? Colors.black
                                        : BuzzerColors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                            childrenPadding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            expandedAlignment: Alignment.centerLeft,
                            children: <Widget>[
                              exam.notes.isNotEmpty
                                  ? Text(exam.notes)
                                  : const SizedBox(
                                      height: 0.0,
                                    ),
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          return Container();
        },
        loading: () {
          return const Loading();
        },
      ),
    );
  }
}
