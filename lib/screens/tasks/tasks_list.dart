import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/tasks/task_tile.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    dynamic tasks = DatabaseService(uid: _auth.toString()).getTasks;

    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
          );
        },
      );
    });
  }
}
