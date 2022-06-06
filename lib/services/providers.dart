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

// final userProvider = StateProvider<BuzzUser>((ref) => BuzzUser(userId: ''));

// final userInfoFetchProvider = FutureProvider<UserInfo>((ref) async {
//   final AuthService _auth = AuthService();

//   final DocumentReference docRef =
//       FirebaseFirestore.instance.collection(_auth.toString()).doc('user_info');

//   final docSnap = await docRef.get();

//   if (docSnap.data() != null) {
//     dynamic userData = docSnap.data();

//     ref.read(userProvider.notifier).state = UserInfo(name: userData['name']);

//     return ref.watch(userProvider);
//   }

//   return UserInfo(name: 'New User');
// });

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
            title: taskData['title'],
            dueDate: taskData['dueDate'],
            category: taskData['tag'],
            details: taskData['notes'],
          ));
    }
  }

  return ref.watch(tasksProvider);
});
