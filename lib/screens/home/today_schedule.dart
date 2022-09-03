import 'package:buzzer/main.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class TodaySchedule extends StatefulWidget {
  const TodaySchedule({Key? key}) : super(key: key);

  @override
  State<TodaySchedule> createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  @override
  Widget build(BuildContext context) {
    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final String weekday = weekdays[DateTime.now().weekday - 1];

    return ValueListenableBuilder<Box<Course>>(
      valueListenable: Hive.box<Course>('classes').listenable(),
      builder: (context, box, widget) {
        final todayClasses = box.values.toList().cast<Course>();

        todayClasses.removeWhere(
            (todayClass) => todayClass.day.compareTo(weekday) != 0);
        todayClasses.sort((a, b) => a.startTime.compareTo(b.startTime));

        todayClasses.removeWhere((todayClass) =>
            (todayClass.endTime.hour < DateTime.now().hour &&
                todayClass.endTime.minute < DateTime.now().minute));

        return todayClasses.isEmpty
            ? Column(
                children: [
                  const SizedBox(height: 20.0),
                  Icon(
                    Icons.celebration_rounded,
                    color: BuzzerColors.grey,
                    size: 40.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'No classes for today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15.0,
                      color: BuzzerColors.grey,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        todayClasses.length > 3 ? 3 : todayClasses.length,
                    itemBuilder: (BuildContext context, int index) {
                      Course todayClass = todayClasses[index];

                      return Card(
                        elevation: 0.0,
                        color: BuzzerColors.lightGrey,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          title: title(todayClass.title, todayClass.type),
                          trailing: trailing(todayClass.startTime),
                          onTap: () {
                            Navigator.of(context).popAndPushNamed('/timetable');
                          },
                        ),
                      );
                    },
                  ),
                  (todayClasses.length - 3) > 0
                      ? ListTile(
                          dense: true,
                          title: Text(
                            '+ ${todayClasses.length - 3} more',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: BuzzerColors.orange,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).popAndPushNamed('/timetable');
                          },
                        )
                      : const SizedBox(),
                ],
              );
      },
    );
  }

  RichText title(
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

  Text trailing(DateTime time) {
    return Text(
      '${DateFormat('Hm', 'en_US').format(time)}  ',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    );
  }
}
