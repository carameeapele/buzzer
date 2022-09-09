import 'package:buzzer/main.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextStyle field = TextStyle(
    fontSize: 12.0,
    fontFamily: 'Roboto',
    letterSpacing: 1.0,
    color: BuzzerColors.grey,
  );

  final preferences = Hive.box('preferences');
  late bool? darkMode = preferences.get('darkMode', defaultValue: true);
  late bool weekendDays = preferences.get('weekendDays', defaultValue: false);
  late int? repeatAfter = preferences.get('repeatAfter', defaultValue: 1);

  late bool countWeeks = preferences.get('countWeeks', defaultValue: false);
  late DateTime firstDay =
      preferences.get('firstDay', defaultValue: DateTime.now());
  late int weekNumber = preferences.get('weekNumber', defaultValue: 1);

  late bool deleteTasks = preferences.get('deleteTasks', defaultValue: false);
  late bool deleteExams = preferences.get('deleteExams', defaultValue: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      endDrawer: const MenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Checkbox(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                      preferences.put('darkMode', darkMode);
                    });
                  },
                )
              ],
            ),
            FilledTextButtonWidget(
              onPressed: () {
                _alertDelete();
              },
              text: 'Reset Buzzer',
              icon: false,
              backgroundColor: BuzzerColors.lightGrey,
              textColor: Colors.black,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Timetable'.toUpperCase(),
              style: field,
            ),
            const Divider(
              height: 20.0,
            ),
            classRow(
              'Weekend days',
              Checkbox(
                value: weekendDays,
                onChanged: (value) {
                  setState(() {
                    weekendDays = value!;
                    preferences.put('weekendDays', value);
                  });
                },
              ),
            ),
            classRow(
              'Count Weeks',
              Checkbox(
                value: countWeeks,
                onChanged: (value) {
                  setState(() {
                    countWeeks = value!;
                    preferences.put('countWeeks', value);
                  });
                },
              ),
            ),
            Opacity(
              opacity: countWeeks ? 1.0 : 0.4,
              child: classRow(
                'First day',
                TextButton(
                  onPressed: () {
                    if (countWeeks) {
                      _selectDate();
                    }
                  },
                  child: Text(DateFormat('dd MMM').format(firstDay)),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Tasks'.toUpperCase(),
              style: field,
            ),
            const Divider(height: 20.0),
            classRow(
              'Automatically delete on complete',
              Checkbox(
                value: deleteTasks,
                onChanged: (value) {
                  setState(() {
                    deleteTasks = value!;
                    preferences.put('deleteTasks', value);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Events'.toUpperCase(),
              style: field,
            ),
            const Divider(height: 20.0),
            classRow(
              'Automatically delete on complete',
              Checkbox(
                value: deleteExams,
                onChanged: (value) {
                  setState(() {
                    deleteExams = value!;
                    preferences.put('deleteExams', value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: firstDay,
      firstDate: DateTime(firstDay.year - 1),
      lastDate: DateTime(firstDay.year + 1),
    );

    if (selectedDate != null) {
      if (selectedDate.weekday != DateTime.monday) {
        firstDay =
            selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
      } else {
        firstDay = selectedDate;
      }

      setState(() {
        preferences.put('firstDay', firstDay);
      });
    }
  }

  Future<void> _alertDelete() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete all data?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Hive.box<Task>('tasks').clear();
                Hive.box<Exam>('exams').clear();
                Hive.box<Project>('projects').clear();
                Hive.box<Category>('categories').clear();
                Hive.box<Course>('classes').clear();

                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
