import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class Exam extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late Timestamp date;

  @HiveField(3)
  late String category;

  @HiveField(4)
  late String details;

  Exam({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.details,
  });
}
