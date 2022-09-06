import 'package:buzzer/models/task_model.dart';
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

  @HiveField(6)
  late HiveList<Task> tasks;

  Project(
    this.id,
    this.title,
    this.category,
    this.date,
    this.time,
    this.complete,
  );
}
