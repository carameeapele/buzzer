import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/style/menu_drawer_widget.dart';
import 'package:buzzer/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: const AppBarWidget(title: 'Calendar'),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const CalendarWidget(),
            const SizedBox(
              height: 8.0,
            ),
            //Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
