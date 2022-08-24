import 'package:buzzer/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

class TasksService with ReactiveServiceMixin {
  final _tasks = ReactiveValue<List<Task>>(
    Hive.box('tasks').get(
      'tasks',
      defaultValue: [],
    ).cast<Task>(),
  );

  List<Task> get tasks => _tasks.value;

  TasksService() {
    listenToReactiveValues([_tasks]);
  }

  String _id() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  void _addToHive() => Hive.box('tasks').put('tasks', _tasks.value);

  void addTask(String title, Timestamp date, Timestamp time, String category,
      String details) {
    _tasks.value.add(Task(
      id: _id(),
      title: title,
      date: date,
      time: time,
      category: category,
      details: details,
      complete: false,
    ));

    _tasks.value.sort((a, b) => a.date.compareTo(b.date));

    _addToHive();
    notifyListeners();
  }

  bool deleteTask(String id) {
    final index = _tasks.value.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks.value.removeAt(index);
      _addToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool completeTask(String id) {
    final index = _tasks.value.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks.value[index].complete = !_tasks.value[index].complete;
      _addToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool editTask(String id, String title, Timestamp date, Timestamp time,
      String category, String details) {
    final index = _tasks.value.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _tasks.value[index].title = title;
      _tasks.value[index].date = date;
      _tasks.value[index].time = time;
      _tasks.value[index].category = category;
      _tasks.value[index].details = details;

      _addToHive();
      return true;
    } else {
      return false;
    }
  }
}
