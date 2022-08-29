import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 5)
class Class extends HiveObject {
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
  String room = '';

  @HiveField(7)
  String professorEmail = '';

  @HiveField(8)
  String details = '';

  Class({
    required this.id,
    required this.title,
    required this.day,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.professorEmail,
    required this.details,
  });
}
