import 'package:buzzer/main.dart';
import 'package:buzzer/screens/events/events.dart';
import 'package:buzzer/screens/home/home.dart';
import 'package:buzzer/screens/home/settings.dart';
import 'package:buzzer/screens/tasks/tasks.dart';
import 'package:buzzer/screens/home/timetable.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final String name;
  final String email;

  const MenuDrawer({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Material(
        color: Colors.deepOrange,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  buidHeader(
                    name: name,
                    college: email,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildMenuItem(
                    text: 'Today',
                    icon: Icons.home_rounded,
                    onClicked: () => selectedItem(context, 'today'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildMenuItem(
                    text: 'Tasks',
                    icon: Icons.check_box_outlined,
                    onClicked: () => selectedItem(context, 'tasks'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildMenuItem(
                    text: 'Timetable',
                    icon: Icons.calendar_view_day_rounded,
                    onClicked: () => selectedItem(context, 'timetable'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buildMenuItem(
                    text: 'Events',
                    icon: Icons.calendar_today_rounded,
                    onClicked: () => selectedItem(context, 'calendar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buidHeader({
  required String name,
  required String college,
  required VoidCallback onClicked,
}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  college,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.white, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ],
        ),
      ),
    );

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white,
    ),
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        fontFamily: 'Roboto',
      ),
    ),
    hoverColor: BuzzerColors.lightOrange,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, String path) {
  Navigator.of(context).pop();

  switch (path) {
    case 'today':
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Home(),
      ));
      break;
    case 'tasks':
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const TasksScreen(),
      ));
      break;
    case 'timetable':
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const TimetableScreen(),
      ));
      break;
    case 'calendar':
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const EventsScreen(),
      ));
      break;
  }
}
