import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({
    required this.uid,
  });

  // collection reference
  // final CollectionReference eventsCollection =
  //     FirebaseFirestore.instance.collection('events');
  // final CollectionReference tasksCollection =
  //     FirebaseFirestore.instance.collection('tasks');
  final userInfoCollection =
      FirebaseFirestore.instance.collection("user_info").withConverter(
            fromFirestore: UserInfo.fromFirestore,
            toFirestore: (UserInfo userInfo, options) => userInfo.toFirestore(),
          );

  // Future updateEvent(String title, DateTime date, String location,
  //     DateTime startTime, DateTime endTime, int reminders, String notes) async {
  //   return await eventsCollection.doc(uid).set({
  //     'title': title,
  //     'date': date,
  //     'location': location,
  //     'startTime': startTime,
  //     'endTime': endTime,
  //     'reminders': reminders,
  //     'notes': notes,
  //   });
  // }

  // Future updateTask(
  //     String title, DateTime dueDate, String category, String details) async {
  //   return await tasksCollection.doc(uid).set({
  //     'title': title,
  //     'dueDate': dueDate,
  //     'category': category,
  //     'details': details,
  //   });
  // }

  // Future updateUserInfo(String name, String college) async {
  //   return await userInfoCollection.doc(uid).set({
  //     'name': name,
  //     'college': college,
  //   });
  // }

  Future addUserInfo(String name, String college) async {
    final newUser = UserInfo(
      name: name,
      college: college,
    );

    final docRef = userInfoCollection.doc(uid);
    await docRef.set(newUser).then(
        (value) =>
            print("On document: ${docRef.id} name: $name college: $college"),
        onError: (e) => print("Error $e"));
  }

  void updateUserInfo(String name, String college) async {
    final docRef = userInfoCollection.doc(uid);
    docRef.update({
      "name": name,
      "college": college,
    });
  }

  Future getUserInfo() async {
    final docRef = userInfoCollection.doc(uid);
    final docSnap = await docRef.get();
    final userInfo = docSnap.data();
    if (userInfo != null) {
      return userInfo;
    } else {
      print("No such document");
    }
  }

  // events from snapshot
  // List<Event>? _eventsListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Event(
  //         title: doc.get('title') ?? '',
  //         date: doc.get('date') ?? DateTime.now(),
  //         location: doc.get('location') ?? '',
  //         startTime: doc.get('startTime') ?? DateTime.now(),
  //         endTime: doc.get('endTime') ?? DateTime.now(),
  //         reminders: doc.get('reminders') ?? 0,
  //         notes: doc.get('notes') ?? '');
  //   }).toList();
  // }

  // tasks from snapshot
  // List<Task>? _tasksListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Task(
  //         title: doc.get('title') ?? '',
  //         dueDate: doc.get('dueDate') ?? DateTime.now(),
  //         category: doc.get('category') ?? 'None',
  //         details: doc.get('details') ?? '');
  //   }).toList();
  // }

  // user info from snapshot
  // List<UserInfo> _userInfoFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return UserInfo(
  //         name: doc.get('name') ?? '', college: doc.get('college') ?? '');
  //   }).toList();
  // }

  // get events stream
  // Stream<List<Event>?> get events {
  //   return eventsCollection.snapshots().map(_eventsListFromSnapshot);
  // }

  // get tasks stream
  // Stream<List<Task>?> get tasks {
  //   return tasksCollection.snapshots().map(_tasksListFromSnapshot);
  // }
}
