import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/tasks/task_tile.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/services/providers.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthService _auth = AuthService();
    final tasksList = ref.watch(tasksFetchProvider);

    return Container(
      child: tasksList.when(
        data: (List<Task> tasks) {
          return Scaffold(
            extendBodyBehindAppBar: false,
            appBar: AppBarWidget(
              title: 'Tasks',
            ),
            drawer: const MenuDrawer(),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (tasks.isEmpty) {
                        return Container();
                      }

                      tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));

                      Task item = tasks[index];
                      return TaskTile(task: item);
                    },
                  ),
                ],
              ),
            )),
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          return Container();
        },
        loading: () {
          return const Loading();
        },
      ),
    );
  }
}
