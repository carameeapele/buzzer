import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/home/todayTasks.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final now = DateTime.now();
  bool loading = false;
  List<Task> tasks = [];

  void getTaskList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: const AppBarWidget(
        title: 'Today',
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                DateFormat('EEEEE', 'en_US').format(now),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                DateFormat('d MMMM', 'en_US').format(now),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Tasks',
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const TodayTasks(),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Schedule',
                style: subtitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
