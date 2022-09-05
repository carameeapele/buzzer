import 'package:buzzer/screens/home/today_events.dart';
import 'package:buzzer/screens/home/today_schedule.dart';
import 'package:buzzer/screens/home/today_tasks.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: todayTitle(
          DateFormat('d MMM').format(now),
          DateFormat('EEEEE').format(now),
        ),
      ),
      endDrawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Tasks', style: subtitleTextStyle),
            const SizedBox(height: 10.0),
            const TodayTasks(),
            const SizedBox(height: 10.0),
            Text('Schedule', style: subtitleTextStyle),
            const SizedBox(height: 10.0),
            const TodaySchedule(),
          ],
        ),
      ),
    );
  }
}
