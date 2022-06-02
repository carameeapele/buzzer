import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/tasks/task_tile.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final AuthService _auth = AuthService();
  List<Task> tasks = [
    Task(
        'Something', Timestamp.fromDate(DateTime(2022, 06, 03)), 'English', ''),
    Task('Something else', Timestamp.fromDate(DateTime(2022, 06, 05)), 'Enlish',
        'details')
  ];

  @override
  Widget build(BuildContext context) {
    //List<Task> tasks = DatabaseService(uid: _auth.toString()).getTaskList();

    return tasks.isEmpty
        ? Text(tasks.length.toString())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskTile(
                task: tasks[index],
              );
            },
          );
  }
}
