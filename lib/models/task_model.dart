import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late Timestamp dueDate;

  @HiveField(3)
  late Timestamp time;

  @HiveField(4)
  late String category;

  @HiveField(5)
  late String details;

  @HiveField(6)
  late bool complete;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
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
      dueDate: data?['dueDate'],
      time: data?['time'],
      category: data?['tag'],
      details: data?['notes'],
      complete: data?['complete'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'dueDate': dueDate,
      'tag': category,
      'notes': details,
      'complete': complete,
    };
  }
}
