import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/models/user_model.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User Info Providers

final authenticationProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<BuzzUser?>((ref) {
  return ref.read(authenticationProvider).user;
});

// Tasks Providers

final tasksProvider = StateProvider<List<Task>>((ref) => <Task>[]);

final tasksFetchProvider = FutureProvider<List<Task>>((ref) async {
  final AuthService _auth = AuthService();

  final collectionRef = FirebaseFirestore.instance
      .collection(_auth.toString())
      .doc('tasks')
      .collection('tasks');

  final docSnap = await collectionRef.get();
  List<DocumentSnapshot> tasksDocs = docSnap.docs.toList();

  for (var doc in tasksDocs) {
    if (doc.data() != null) {
      dynamic taskData = doc.data();

      ref.read(tasksProvider.notifier).state.add(Task(
            id: doc.id,
            title: taskData['title'],
            dueDate: taskData['dueDate'],
            category: taskData['tag'],
            notes: taskData['notes'],
            complete: taskData['complete'] ?? false,
          ));

      ref
          .read(tasksProvider.notifier)
          .state
          .sort((a, b) => a.dueDate.compareTo(b.dueDate));
    }
  }

  return ref.watch(tasksProvider);
});

final completeTasksProvider = StateProvider<List<Task>>((ref) {
  return <Task>[];
});

final completeTasksFetchProvider = FutureProvider<List<Task>>((ref) {
  final tasks = ref.read(tasksProvider.notifier).state;

  for (var task in tasks) {
    if (task.complete) {
      ref.read(completeTasksProvider.notifier).state.add(task);
    }
  }

  return ref.watch(completeTasksProvider);
});

// Events Providers

final examsProvider = StateProvider<List<Exam>>((ref) => <Exam>[]);

final examsFetchProvider = FutureProvider<List<Exam>>((ref) async {
  final AuthService _auth = AuthService();
  final collectionRef = FirebaseFirestore.instance
      .collection(_auth.toString())
      .doc('events')
      .collection('exams');

  final docSnap = await collectionRef.get();
  List<DocumentSnapshot> examsDocs = docSnap.docs.toList();

  for (var doc in examsDocs) {
    if (doc.data() != null) {
      dynamic examData = doc.data();

      ref.read(examsProvider.notifier).state.add(
            Exam(
              id: doc.id,
              title: examData['title'],
              date: examData['date'],
              tag: examData['tag'],
              reminders: examData['remindes'] ?? 0,
              notes: examData['notes'],
            ),
          );

      ref
          .read(examsProvider.notifier)
          .state
          .sort((a, b) => a.date.compareTo(b.date));
    }
  }
  return ref.watch(examsProvider);
});
