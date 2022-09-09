import 'package:buzzer/main.dart';
import 'package:buzzer/screens/timetable/add_class.dart';
import 'package:buzzer/screens/timetable/class_list.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen>
    with TickerProviderStateMixin {
  DateTime now = DateTime.now();
  late int initialIndex = now.weekday - 1;

  final preferences = Hive.box('preferences');
  late bool weekendDays = preferences.get('weekendDays', defaultValue: false);

  late bool countWeeks = preferences.get('countWeeks', defaultValue: false);
  late DateTime firstDay =
      preferences.get('firstDay', defaultValue: DateTime.now());
  late int weekNumber = preferences.get('weekNumber', defaultValue: 1);

  late int repeatAfter = preferences.get('repeatAfter', defaultValue: 1);

  @override
  void initState() {
    _weekCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController _controller = TabController(
      initialIndex:
          initialIndex > 4 ? (weekendDays ? initialIndex : 0) : initialIndex,
      length: weekendDays ? 7 : 5,
      vsync: this,
    );

    TabBar tabBar = TabBar(
      controller: _controller,
      isScrollable: true,
      indicatorColor: Colors.transparent,
      labelStyle: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
      tabs: <Widget>[
        const Tab(text: 'Monday'),
        const Tab(text: 'Tuesday'),
        const Tab(text: 'Wednesday'),
        const Tab(text: 'Thursday'),
        const Tab(text: 'Friday'),
        if (weekendDays) const Tab(text: 'Saturday'),
        if (weekendDays) const Tab(text: 'Sunday'),
      ],
    );

    final double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        120.0;

    return Scaffold(
      appBar: AppBar(
        title: countWeeks ? Text('Week $weekNumber') : const Text('Timetable'),
      ),
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
                children: <Widget>[
                  const ClassList(day: 'Monday'),
                  const ClassList(day: 'Tuesday'),
                  const ClassList(day: 'Wednesday'),
                  const ClassList(day: 'Thursday'),
                  const ClassList(day: 'Friday'),
                  if (weekendDays) const ClassList(day: 'Saturday'),
                  if (weekendDays) const ClassList(day: 'Sunday'),
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
                builder: (context) =>
                    AddClass(day: 'Monday', week: repeatAfter),
              ));
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Tuesday', week: 1),
              ));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Wednesday', week: 1),
              ));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Thursday', week: 1),
              ));
              break;
            case 4:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Friday', week: 1),
              ));
              break;
            case 5:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Saturday', week: 1),
              ));
              break;
            case 6:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddClass(day: 'Sunday', week: 1),
              ));
          }
        },
      ),
    );
  }

  void _weekCounter() {
    if (countWeeks) {
      final difference = DateTime.now().difference(firstDay);
      int days = difference.inDays.toInt();

      if (days / 7 <= 1) {
        setState(() {
          weekNumber = 1;
          preferences.put('weekNumber', weekNumber);
        });
      } else {
        setState(() {
          weekNumber = (days / 7).round() + 1;
          preferences.put('weekNumber', weekNumber);
        });
      }
    }
  }
}
