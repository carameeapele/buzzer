import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({
    required this.uid,
  });

  Future<List<Task>> getTasks() async {
    final docRef = FirebaseFirestore.instance
        .collection(uid)
        .doc('tasks')
        .collection('tasks');

    final docSnap = await docRef.get();
    List<DocumentSnapshot> tasksDocs = docSnap.docs.toList();
    List<Task> tasks = [];

    if (docSnap != null) {
      for (var doc in tasksDocs) {
        if (doc.data() != null) {
          dynamic taskData = doc.data();

          tasks.add(Task(
            title: taskData['title'],
            dueDate: taskData['dueDate'],
            category: taskData['tag'],
            details: taskData['notes'],
          ));
        }
      }
    } else {
      print('Unexpected error');
    }

    return tasks;
  }

  Future getUserInfo() async {
    final docRef = FirebaseFirestore.instance.collection(uid).doc('user_info');
    final docSnap = await docRef.get();
    final userInfo = docSnap.data();
    if (userInfo != null) {
      print(userInfo.toString());
      return userInfo;
    } else {
      return UserInfo(name: 'New User');
    }
  }

  Future updateUserInfo(String name) async {
    final docRef = FirebaseFirestore.instance.collection(uid).doc('user_info');
    docRef
        .update({'name': name})
        .then((value) => print('User Updated'))
        .catchError((error) => print('Unexpected error: $error'));
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
}
