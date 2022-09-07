import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class ReminderPicker extends StatefulWidget {
  const ReminderPicker({
    Key? key,
    required this.selectedReminder,
  }) : super(key: key);

  final String selectedReminder;

  @override
  State<ReminderPicker> createState() => _ReminderPickerState();
}

class _ReminderPickerState extends State<ReminderPicker> {
  List<String> reminders = [
    'None',
    '10 minutes before',
    '30 minutes before',
    '1 hour before',
    '2 hours before',
    'On the day of event (08:00)',
    'One day before',
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
                      ? const Icon(
                          Icons.check,
                          size: 20.0,
                          color: Colors.white,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedReminder = reminder;
                      Navigator.pop(context, selectedReminder);
                    });
                  },
                ),
                false,
              );
            },
          ),
        ),
      ),
    );
  }
}
