// final today = DateTime.now();
// final firstDay = DateTime(today.year, today.month - 3, today.day);
// final lastDay = DateTime(today.year, today.month + 3, today.day);

import 'package:buzzer/screens/movies/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final DateTime date;
  final String tag;
  final int reminders;
  final String notes;

  Event({
    required this.title,
    required this.date,
    required this.tag,
    required this.reminders,
    required this.notes,
  });

  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Event(
      title: data?['title'] as String,
      date: data?['date'] as DateTime,
      tag: data?['tag'] as String,
      reminders: data?['reminders'] as int,
      notes: data?['notes'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (date != null) 'date': date,
      if (tag != null) 'tag': tag,
      if (reminders != null) 'reminders': reminders,
      if (notes != null) 'notes': notes,
    };
  }
}
