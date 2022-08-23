import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'task_model.g.dart';

class Task {
  late String id;
  late String title;
  late Timestamp date;
  late Timestamp time;
  late String category;
  late String details;
  late bool complete;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.category,
    required this.details,
    required this.complete,
  });

  void editComplete() async {
    complete = !complete;
  }

  factory Task.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Task(
      id: snapshot.id,
      title: data?['title'],
      date: data?['dueDate'],
      time: data?['time'],
      category: data?['tag'],
      details: data?['notes'],
      complete: data?['complete'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'dueDate': date,
      'tag': category,
      'notes': details,
      'complete': complete,
    };
  }
}
