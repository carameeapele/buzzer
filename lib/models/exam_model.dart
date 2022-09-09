import 'package:hive/hive.dart';

@HiveType(typeId: 8)
class Exam extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late DateTime time;

  @HiveField(4)
  late String category;

  @HiveField(5)
  String details = '';

  @HiveField(6)
  String room = '';

  @HiveField(7)
  String building = '';

  Exam({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.category,
    required this.details,
    required this.room,
    required this.building,
  });
}
