import 'package:buzzer/main.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/screens/events/exams/edit_exam.dart';
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
            'Click + to add an exam',
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
        exams.sort((a, b) => a.date.compareTo(b.date));

        return exams.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                itemCount: exams.length,
                itemBuilder: (BuildContext context, int index) {
                  Exam exam = exams[index];
                  DateTime now = DateTime.now();
                  bool _isToday = (exam.date.day == now.day &&
                      exam.date.month == now.month &&
                      exam.date.year == now.year);

                  return Card(
                    elevation: 0.0,
                    color: _isToday ? Colors.white : BuzzerColors.lightGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.0)),
                      side: BorderSide(
                        color:
                            _isToday ? BuzzerColors.orange : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: Theme(
                      data: data,
                      child: ExpansionTile(
                        tilePadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        title: _title(
                            exam.title, exam.category, exam.date, exam.time),
                        trailing: _trailing(exam.date, exam.time),
                        childrenPadding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 12.0, 0.0),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        children: <Widget>[
                          _details(exam),
                          exam.details.isNotEmpty
                              ? const SizedBox(height: 10.0)
                              : const SizedBox(),
                          exam.details.isNotEmpty
                              ? Text(exam.details)
                              : const SizedBox(),
                          _options(exam),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  RichText _title(
    String title,
    String tag,
    DateTime date,
    DateTime time,
  ) {
    DateTime now = DateTime.now();
    bool _isBefore = (date.isBefore(now));

    return RichText(
      text: TextSpan(
        text: tag,
        style: TextStyle(
          color: (_isBefore && time.isBefore(now))
              ? BuzzerColors.grey
              : Colors.black,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
          decoration: (_isBefore && time.isBefore(now))
              ? TextDecoration.lineThrough
              : null,
          decorationThickness: 2.0,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '  $title',
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

  Text _trailing(DateTime date, DateTime time) {
    DateTime now = DateTime.now();
    bool _isToday = (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year);

    return Text(
      _isToday
          ? DateFormat('Hm', 'en_US').format(time)
          : DateFormat('dd MMM', 'en_US').format(date),
      style: TextStyle(
        color: ((date.isBefore(now) && time.isBefore(now)))
            ? BuzzerColors.grey
            : Colors.black,
        fontSize: 16.0,
      ),
    );
  }

  void _deleteExam(Exam exam) {
    exam.delete();
  }

  Row _details(Exam exam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.access_time_filled,
          size: 18.0,
          color: BuzzerColors.orange,
        ),
        const SizedBox(width: 5.0),
        Text(
          DateFormat('Hm', 'en_US').format(exam.time),
          style: const TextStyle(
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(width: 20.0),
        Icon(
          Icons.meeting_room,
          size: 18.0,
          color: BuzzerColors.orange,
        ),
        const SizedBox(width: 5.0),
        exam.room.isNotEmpty ? Text(exam.room) : const SizedBox(),
      ],
    );
  }

  Row _options(Exam exam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditExam(
                  exam: exam,
                ),
              ),
            );
          },
          child: const Text(
            'Edit',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          style: TextButton.styleFrom(primary: BuzzerColors.grey),
        ),
        TextButton(
          onPressed: () {
            _deleteExam(exam);
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          style: TextButton.styleFrom(primary: BuzzerColors.grey),
        ),
      ],
    );
  }
}
