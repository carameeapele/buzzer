import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  final String id;
  final String title;
  final Timestamp date;
  final String tag;
  final int reminders;
  final String notes;

  Exam({
    required this.id,
    required this.title,
    required this.date,
    required this.tag,
    required this.reminders,
    required this.notes,
  });
}
