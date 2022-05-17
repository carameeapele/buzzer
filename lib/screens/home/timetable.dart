import 'package:buzzer/components/app_bar_widget.dart';
import 'package:buzzer/components/menu_drawer.dart';
import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        title: 'Timetable',
      ),
      drawer: MenuDrawer(),
    );
  }
}
