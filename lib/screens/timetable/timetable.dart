import 'package:buzzer/widgets/add_app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';

import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AddAppBarWidget(
        title: 'Timetable',
        onPressed: () {},
      ),
      drawer: const MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
