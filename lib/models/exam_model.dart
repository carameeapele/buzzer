import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
// part 'exam_model.g.dart';

@HiveType(typeId: 2)
class Exam extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late Timestamp date;

  @HiveField(3)
  late String tag;

  @HiveField(4)
  late int reminders;

  @HiveField(5)
  late String notes;

  Exam({
    required this.id,
    required this.title,
    required this.date,
    required this.tag,
    required this.reminders,
    required this.notes,
  });
}
