import 'package:buzzer/main.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/services/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class EventsList extends StatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

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
            'Click + to add an event',
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

    return ValueListenableBuilder<Box<Exam>>(
      valueListenable: Hive.box<Exam>('exams').listenable(),
      builder: (context, box, widget) {
        final exams = box.values.toList().cast<Exam>();

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
                        title: title(exam.title, exam.category, exam.date),
                        trailing: trailing(exam.date),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 0.0,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        children: <Widget>[
                          exam.details.isNotEmpty
                              ? Text(exam.details)
                              : const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {});
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
                                  setState(() {});
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
