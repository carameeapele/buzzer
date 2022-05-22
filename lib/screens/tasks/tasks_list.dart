import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/tasks/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          task: tasks[index],
        );
      },
    );
  }
}
