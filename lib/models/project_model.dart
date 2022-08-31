import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class Project extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String category;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late DateTime time;

  @HiveField(5)
  late bool complete;

  Project({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.complete,
  });
}
