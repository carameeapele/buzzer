import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class ClassReminderPicker extends StatefulWidget {
  const ClassReminderPicker({
    Key? key,
    required this.selectedReminder,
  }) : super(key: key);

  final String selectedReminder;

  @override
  State<ClassReminderPicker> createState() => _ClassReminderPickerState();
}

class _ClassReminderPickerState extends State<ClassReminderPicker> {
  List<String> reminders = [
    'None',
    '10 minutes before',
    '30 minutes before',
    '1 hour before',
  ];
  late String selectedReminder = widget.selectedReminder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 20.0),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: reminders.length,
            itemBuilder: (BuildContext context, int index) {
              final reminder = reminders[index];

              return customCard(
                ListTile(
                  selected: (selectedReminder.compareTo(reminder) == 0),
                  selectedColor: BuzzerColors.orange,
                  dense: true,
                  title: Text(
                    reminder,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  trailing: (selectedReminder.compareTo(reminder) == 0)
                      ? Icon(
                          Icons.check,
                          size: 20.0,
                          color: BuzzerColors.orange,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedReminder = reminder;
                      Navigator.pop(context, selectedReminder);
                    });
                  },
                ),
                (selectedReminder.compareTo(reminder) == 0),
              );
            },
          ),
        ),
      ),
    );
  }
}
