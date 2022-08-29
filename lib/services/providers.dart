import 'package:buzzer/models/project_model.dart';
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
            date: taskData['dueDate'],
            time: taskData['time'],
            category: taskData['tag'],
            details: taskData['notes'],
            complete: taskData['complete'] ?? false,
          ));

      ref
          .read(tasksProvider.notifier)
          .state
          .sort((a, b) => a.date.compareTo(b.date));
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

// final examsProvider = StateProvider<List<Exam>>((ref) => <Exam>[]);

// final examsFetchProvider = FutureProvider<List<Exam>>((ref) async {
//   final AuthService _auth = AuthService();
//   final collectionRef = FirebaseFirestore.instance
//       .collection(_auth.toString())
//       .doc('events')
//       .collection('exams');

//   final snap = await collectionRef.get();
//   List<DocumentSnapshot> docs = snap.docs.toList();

//   for (var doc in docs) {
//     if (doc.data() != null) {
//       dynamic data = doc.data();

//       ref.read(examsProvider.notifier).state.add(
//             Exam(
//               id: doc.id,
//               title: data['title'],
//               date: data['date'],
//               time: data['time'],
//               category: data['tag'],
//               details: data['notes'],
//             ),
//           );

//       ref
//           .read(examsProvider.notifier)
//           .state
//           .sort((a, b) => a.date.compareTo(b.date));
//     }
//   }
//   return ref.watch(examsProvider);
// });

// Projects Provider

final projectsProvider = StateProvider<List<Project>>((ref) => <Project>[]);

final projectsFetchProvider = FutureProvider<List<Project>>((ref) async {
  final AuthService _auth = AuthService();
  final collectionRef = FirebaseFirestore.instance
      .collection(_auth.toString())
      .doc('events')
      .collection('projects');

  final docSnap = await collectionRef.get();
  List<DocumentSnapshot> projectDocs = docSnap.docs.toList();

  for (var doc in projectDocs) {
    if (doc.data() != null) {
      dynamic data = doc.data();

      ref.read(projectsProvider.notifier).state.add(
            Project(
              id: doc.id,
              title: data['title'],
              category: data['category'],
              date: data['date'],
              time: data['time'],
              complete: data['complete'],
            ),
          );

      ref
          .read(projectsProvider.notifier)
          .state
          .sort((a, b) => a.date.compareTo(b.date));
    }
  }
  return ref.watch(projectsProvider);
});
