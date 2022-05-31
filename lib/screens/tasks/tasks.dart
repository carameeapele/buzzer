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

  dynamic userName;
  Future<dynamic> getUserName() async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection('user_info')
        .doc(_auth.toString());

    await docRef.get().then<dynamic>((DocumentSnapshot snapshot) async {
      if (snapshot.data() != null) {
        setState(() {
          userName = snapshot.data();
        });
      } else {
        setState(() {
          error = 'Could not connect to databse';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        title: 'Tasks',
      ),
      drawer: MenuDrawer(),
    );
  }
}
