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
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: ListTile(
          title: Text(task.title),
          trailing: Text(DateFormat.Hm(task.dueDate).toString()),
        ),
      ),
    );
  }
}
