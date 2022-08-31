import 'package:buzzer/main.dart';
import 'package:buzzer/screens/timetable/add_class.dart';
import 'package:buzzer/screens/timetable/class_list.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen>
    with TickerProviderStateMixin {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    late int initialIndex = now.weekday - 1;

    TabController _controller = TabController(
      initialIndex: initialIndex,
      length: 5,
      vsync: this,
    );

    AppBarWidget appBar = const AppBarWidget(title: 'Timetable');

    TabBar tabBar = TabBar(
      controller: _controller,
      isScrollable: true,
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelColor: BuzzerColors.grey,
      indicatorColor: Colors.white,
      tabs: const <Widget>[
        Tab(text: 'Monday'),
        Tab(text: 'Tuesday'),
        Tab(text: 'Wednesday'),
        Tab(text: 'Thursday'),
        Tab(text: 'Friday'),
      ],
    );

    final double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        68.0;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: appBar,
      endDrawer: const MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          tabBar,
          SizedBox(
            height: height,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TabBarView(
                controller: _controller,
                children: const <Widget>[
                  ClassList(day: 'Monday'),
                  ClassList(day: 'Tuesday'),
                  ClassList(day: 'Wednesday'),
                  ClassList(day: 'Thursday'),
                  ClassList(day: 'Friday'),
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
          switch (_controller.index) {
            case 0:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Monday'),
              ));
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Tuesday'),
              ));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Wednesday'),
              ));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Thursday'),
              ));
              break;
            case 4:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Friday'),
              ));
              break;
          }
        },
      ),
    );
  }
}
