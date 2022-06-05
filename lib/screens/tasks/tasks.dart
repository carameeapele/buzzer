import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/tasks/tasks_list.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final AuthService _auth = AuthService();

  bool loading = false;
  String error = '';
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBarWidget(
        title: 'Tasks',
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                final docRef = FirebaseFirestore.instance
                    .collection(_auth.toString())
                    .doc('tasks')
                    .collection('tasks');

                final doc = await FirebaseFirestore.instance
                    .collection(_auth.toString())
                    .doc('tasks');

                final snap = await doc.get();
                // DocumentSnapshot docsnap = snap.data();

                final docSnap = await docRef.get();
                List<DocumentSnapshot> tasksDocs = docSnap.docs.toList();

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

                tasks.forEach((element) {
                  print(element.title);
                });
              },
              child: const Text('Get Tasks'),
            ),
            const TasksList(),
          ],
        ),
      )),
    );
  }
}
