import 'package:buzzer/components/app_bar_widget.dart';
import 'package:buzzer/components/menu_drawer.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(title: 'Calendar'),
      drawer: MenuDrawer(),
    );
  }
}
