import 'package:buzzer/models/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  // collection reference
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  Future updateUserData(String title, DateTime date, String location,
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

  // get events stream
  Stream<List<Event>?> get events {
    return eventsCollection.snapshots().map(_eventsListFromSnapshot);
  }
}
