import 'package:buzzer/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Project {
  late String title;
  late Timestamp date;
  late TimeOfDay time;
  late List<Task> tasks;
}
