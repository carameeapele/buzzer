import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    required this.uid,
  });

  Future addTasks(Task task) async {
    final collectionRef = FirebaseFirestore.instance
        .collection(uid)
        .doc('tasks')
        .collection('tasks');

    final docData = {
      'title': task.title,
      'dueDate': task.dueDate,
      'tag': task.category,
      'notes': task.details,
      'complete': task.complete,
    };

    collectionRef.add(docData).then((documentSnapshot) =>
        print('Added data with id: ${documentSnapshot.id}'));
  }

  Future completeTask(String id, bool complete) async {
    final docRef = FirebaseFirestore.instance
        .collection(uid)
        .doc('tasks')
        .collection('tasks')
        .doc(id);

    docRef.update({'complete': complete}).catchError(
        (error) => print('Error: $error'));
  }

  Future deleteTask(String id) async {
    final docRef = FirebaseFirestore.instance
        .collection(uid)
        .doc('tasks')
        .collection('tasks')
        .doc(id);

    docRef
        .delete()
        .then((value) => print('Deleted'))
        .catchError((error) => print('Delete doc $id failed: $error'));
  }

  void addExam(exam) {
    final collectionRef = FirebaseFirestore.instance
        .collection(uid)
        .doc('events')
        .collection('exams');

    collectionRef.add(exam);
  }

  void deleteExam(String id) {
    FirebaseFirestore.instance
        .collection(uid)
        .doc('events')
        .collection('exams')
        .doc(id)
        .delete();
  }

  Future updateUserInfo(String name) async {
    final docRef = FirebaseFirestore.instance.collection(uid).doc('user_info');
    docRef
        .update({'name': name})
        .then((value) => print('User Updated'))
        .catchError((error) => print('Unexpected error: $error'));
  }

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
}
