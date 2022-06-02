import 'package:buzzer/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Task {
  String title;
  Timestamp dueDate;
  String category;
  String details;

  Task(this.title, this.dueDate, this.category, this.details);
}
