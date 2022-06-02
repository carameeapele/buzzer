import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final Timestamp dueDate;
  final String category;
  final String details;

  Task({
    required this.title,
    required this.dueDate,
    required this.category,
    required this.details,
  });

  factory Task.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Task(
      title: data?['title'],
      dueDate: data?['dueDate'],
      category: data?['tag'],
      details: data?['notes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'dueDate': dueDate,
      'tag': category,
      'notes': details,
    };
  }
}
