import 'package:buzzer/main.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/screens/timetable/edit_class.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class ClassList extends StatefulWidget {
  const ClassList({
    Key? key,
    required this.day,
  }) : super(key: key);

  final String day;

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) {
    final String day = widget.day;
    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    Widget defaultScreen = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Text(
        'Click + to add a class',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.grey[300],
          fontSize: 16.0,
        ),
      ),
    );

    return ValueListenableBuilder<Box<Course>>(
      valueListenable: Hive.box<Course>('classes').listenable(),
      builder: (context, box, widget) {
        final classes = box.values.toList().cast<Course>();
        classes.removeWhere((element) => element.day.compareTo(day) != 0);
        if (classes.isNotEmpty) {
          classes.sort((a, b) => a.startTime.compareTo(b.startTime));
        }

        return classes.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                itemCount: classes.length,
                itemBuilder: (BuildContext context, int index) {
                  Course dayClass = classes[index];

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
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        title: _title(dayClass.title, dayClass.type),
                        trailing:
                            _trailing(dayClass.startTime, dayClass.endTime),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 0.0,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        children: <Widget>[
                          _details(dayClass),
                          dayClass.details.isNotEmpty
                              ? const SizedBox(height: 10.0)
                              : const SizedBox(),
                          dayClass.details.isNotEmpty
                              ? Text(dayClass.details)
                              : const SizedBox(),
                          _options(dayClass),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  void _deleteClass(Course dayClass) {
    dayClass.delete();
  }

  RichText _title(
    String title,
    String type,
  ) {
    return RichText(
      text: TextSpan(
        text: (type.compareTo('None') == 0) ? '' : type,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
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

  Text _trailing(DateTime startTime, DateTime endTime) {
    return Text(
      '${DateFormat('Hm', 'en_US').format(startTime)}\n${DateFormat('Hm').format(endTime)}',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    );
  }

  Row _details(Course classs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.meeting_room,
          size: 18.0,
          color: BuzzerColors.orange,
        ),
        const SizedBox(width: 5.0),
        classs.room.isNotEmpty ? Text(classs.room) : const SizedBox(),
        const SizedBox(width: 10.0),
        Icon(
          Icons.alternate_email_rounded,
          size: 18.0,
          color: BuzzerColors.orange,
        ),
        const SizedBox(width: 5.0),
        classs.professorEmail.isNotEmpty
            ? Text(classs.professorEmail)
            : const Text(''),
      ],
    );
  }

  Row _options(Course dayClass) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditClass(classs: dayClass),
              ),
            );
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
            _deleteClass(dayClass);
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
