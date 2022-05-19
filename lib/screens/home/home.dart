import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Future<List<Movie>> movies;
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    //movies = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        title: 'Today',
      ),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              DateFormat('EEEEE', 'en_US').format(now),
              style: const TextStyle(
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
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Tasks',
              style: subtitleTextStyle,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Schedule',
              style: subtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
