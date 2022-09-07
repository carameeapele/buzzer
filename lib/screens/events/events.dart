import 'package:buzzer/main.dart';
import 'package:buzzer/screens/events/exams/exams_list.dart';
import 'package:buzzer/screens/events/projects/projects_list.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _controller = TabController(
      length: 2,
      vsync: this,
    );

    AppBar appBar = AppBar(title: const Text('Events'));

    TabBar tabBar = TabBar(
      controller: _controller,
      isScrollable: true,
      labelStyle: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
      indicatorColor: Colors.transparent,
      tabs: const <Widget>[
        Tab(text: 'Exams'),
        Tab(text: 'Projects'),
      ],
    );

    final double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        120.0;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: appBar,
      endDrawer: const MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          tabBar,
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: height,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TabBarView(
                controller: _controller,
                children: const [
                  EventsList(),
                  ProjectsList(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        icon: Icon(
          Icons.add_box,
          color: BuzzerColors.orange,
        ),
        iconSize: 35.0,
        padding: const EdgeInsets.all(0.0),
        onPressed: () {
          if (_controller.index == 0) {
            Navigator.of(context).pushNamed('/add_exam');
          } else {
            Navigator.of(context).pushNamed('/add_project');
          }
        },
      ),
    );
  }
}
