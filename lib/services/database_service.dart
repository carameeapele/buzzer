import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future updateEvent(String title, DateTime date, String location,
      DateTime startTime, DateTime endTime, int reminders, String notes) async {
    return await eventsCollection.doc(uid).set({
      'title': title,
      'date': date,
      'location': location,
      'startTime': startTime,
      'endTime': endTime,
      'reminders': reminders,
      'notes': notes,
    });
  }

  Future updateTask(
      String title, DateTime dueDate, String category, String details) async {
    return await tasksCollection.doc(uid).set({
      'title': title,
      'dueDate': dueDate,
      'category': category,
      'details': details,
    });
  }

  // events from snapshot
  List<Event>? _eventsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Event(
          doc.get('title') ?? '',
          doc.get('date') ?? DateTime.now(),
          doc.get('location') ?? '',
          doc.get('startTime') ?? DateTime.now(),
          doc.get('endTime') ?? DateTime.now(),
          doc.get('reminders') ?? 0,
          doc.get('notes') ?? '');
    }).toList();
  }

  // tasks from snapshot
  List<Task> _tasksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(doc.get('title') ?? '', doc.get('dueDate') ?? DateTime.now(),
          doc.get('category') ?? 'None', doc.get('details') ?? '');
    }).toList();
  }

  // get events stream
  Stream<List<Event>?> get events {
    return eventsCollection.snapshots().map(_eventsListFromSnapshot);
  }

  // get tasks stream
  Stream<List<Task>> get tasks {
    return tasksCollection.snapshots().map(_tasksListFromSnapshot);
  }
}
