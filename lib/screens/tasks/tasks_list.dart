import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TasksList extends ConsumerWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Task>> taskList = ref.watch(tasksFetchProvider);

    return Container(
      child: taskList.when(
        data: (List<Task> tasks) {
          return const Scaffold();
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
