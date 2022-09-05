import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(2)
  late String title;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late DateTime time;

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
}
