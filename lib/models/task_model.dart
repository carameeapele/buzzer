import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final Timestamp dueDate;
  final String category;
  final String notes;
  late bool complete;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.category,
    required this.notes,
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
      category: data?['tag'],
      notes: data?['notes'],
      complete: data?['complete'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'dueDate': dueDate,
      'tag': category,
      'notes': notes,
      'complete': complete,
    };
  }
}
