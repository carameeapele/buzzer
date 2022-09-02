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
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
