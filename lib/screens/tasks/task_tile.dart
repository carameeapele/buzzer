import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Card(
        margin: const EdgeInsets.only(top: 5.0),
        elevation: 0.0,
        color: BuzzerColors.lightGrey,
        child: ListTile(
          title: Text(task.title),
          trailing:
              Text(DateFormat('d MMMM', 'en_US').format(task.dueDate.toDate())),
        ),
      ),
    );
  }
}
