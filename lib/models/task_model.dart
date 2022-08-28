import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(2)
  late String title;

  @HiveField(3)
  late Timestamp date;

  @HiveField(4)
  late Timestamp time;

  @HiveField(5)
  late String category;

  @HiveField(6)
  late String details;

  @HiveField(7)
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

  // factory Task.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return Task(
  //     id: snapshot.id,
  //     title: data?['title'],
  //     date: data?['dueDate'],
  //     time: data?['time'],
  //     category: data?['tag'],
  //     details: data?['notes'],
  //     complete: data?['complete'],
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     'title': title,
  //     'dueDate': date,
  //     'tag': category,
  //     'notes': details,
  //     'complete': complete,
  //   };
  // }
}
