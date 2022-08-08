import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'class_model.g.dart';

@HiveType(typeId: 4)
class Class extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String type;

  @HiveField(2)
  late TimeOfDay startTime;

  @HiveField(3)
  late TimeOfDay endTime;

  @HiveField(4)
  late String day;

  @HiveField(5)
  late String details;
}
