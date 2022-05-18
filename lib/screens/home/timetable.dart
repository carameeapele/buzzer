import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/style/menu_drawer_widget.dart';

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
