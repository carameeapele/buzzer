import 'package:hive/hive.dart';

@HiveType(typeId: 9)
class Course extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String day;

  @HiveField(3)
  late String type;

  @HiveField(4)
  late DateTime startTime;

  @HiveField(5)
  late DateTime endTime;

  @HiveField(6)
  late String room;

  @HiveField(7)
  late String professorEmail;

  @HiveField(8)
  late String details;

  @HiveField(9)
  late int week;

  Course({
    required this.id,
    required this.title,
    required this.day,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.professorEmail,
    required this.details,
    required this.week,
  });
}
