import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/services/tasks.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:buzzer/locator.dart';

class TasksViewModel extends ReactiveViewModel {
  final _tasksService = getIt<TasksService>();

  late final completeTask = _tasksService.completeTask;
  late final deleteTask = _tasksService.deleteTask;
  late final editTask = _tasksService.editTask;

  List<Task> get tasks => _tasksService.tasks;

  void addTask(String title, Timestamp date, Timestamp time, String category,
      String details) {
    _tasksService.addTask(title, date, time, category, details);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_tasksService];
}
