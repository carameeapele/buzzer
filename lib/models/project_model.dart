import 'package:buzzer/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Project {
  late String id;
  late String title;
  late String category;
  late Timestamp date;
  late TimeOfDay time;
  late bool complete;
  late List<Task> tasks;

  Project({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.complete,
  });
}
