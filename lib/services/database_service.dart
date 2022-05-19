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
}
