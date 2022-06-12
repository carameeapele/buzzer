import 'package:buzzer/main.dart';
import 'package:buzzer/screens/events/events.dart';
import 'package:buzzer/screens/home/home.dart';
import 'package:buzzer/screens/settings/settings.dart';
import 'package:buzzer/screens/tasks/tasks.dart';
import 'package:buzzer/screens/timetable/timetable.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final AuthService _auth = AuthService();

  String name = '';
  String email = '';
  String error = '';

  Future<dynamic> getUserData() async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection(_auth.toString())
        .doc('user_info');

    await docRef.get().then<dynamic>((DocumentSnapshot snapshot) async {
      if (snapshot.data() != null) {
        dynamic userData = snapshot.data();
        name = userData['name'];
      } else {
        error = 'Could not connect to databse';
        name = 'Name';
      }
    });

    email = _auth.getEmail();
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Material(
        color: BuzzerColors.orange,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                FutureBuilder(
                    future: getUserData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return buidHeader(
                        name: name,
                        email: email,
                        onClicked: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        )),
                      );
                    }),
                const SizedBox(
                  height: 40.0,
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
          ],
        ),
      ),
    );
  }
}

Widget buidHeader({
  required String name,
  required String email,
  required VoidCallback onClicked,
}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
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
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
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
    contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
    title: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
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
