import 'package:buzzer/main.dart';
import 'package:buzzer/screens/home/calendar.dart';
import 'package:buzzer/screens/home/home.dart';
import 'package:buzzer/screens/home/settings.dart';
import 'package:buzzer/screens/home/tasks.dart';
import 'package:buzzer/screens/home/timetable.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Material(
        color: Colors.deepOrange,
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Today',
                    onClicked: () => selectedItem(context, 'today'),
                  ),
                  buildMenuItem(
                    text: 'Tasks',
                    onClicked: () => selectedItem(context, 'tasks'),
                  ),
                  buildMenuItem(
                    text: 'Timetable',
                    onClicked: () => selectedItem(context, 'timetable'),
                  ),
                  buildMenuItem(
                    text: 'Calendar',
                    onClicked: () => selectedItem(context, 'calendar'),
                  ),
                  buildMenuItem(
                    text: 'Settins',
                    onClicked: () => selectedItem(context, 'settings'),
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

// Widget buidHeader({
//   required String image,
//   required String name,
//   required String email,
//   required VoidCallback onClicked,
// }) =>
//     InkWell(
//       onTap: onClicked,
//       child: Container(
//         child: Row(),
//       ),
//     );

Widget buildMenuItem({
  required String text,
  VoidCallback? onClicked,
}) {
  return ListTile(
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
        builder: (context) => const CalendarScreen(),
      ));
      break;
    case 'settings':
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ));
      break;
  }
}
