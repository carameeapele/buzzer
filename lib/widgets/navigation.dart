import 'package:buzzer/main.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;

  const AddAppBarWidget({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      title: Text(
        title,
        style: appBarTextStyle,
      ),
      titleSpacing: 0.0,
      actions: <Widget>[
        IconButton(
          iconSize: 30.0,
          icon: Icon(
            Icons.add_box_rounded,
            color: BuzzerColors.orange,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      title: Text(
        title,
        style: appBarTextStyle,
      ),
      titleSpacing: 0.0,
    );
  }
}

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
        error = 'Could not connect to the databse';
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
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return buidHeader(
                      name: name,
                      email: email,
                      onTap: () {
                        Navigator.of(context).popAndPushNamed('/settings');
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                (ModalRoute.of(context)!.settings.name == '/home')
                    ? menuItem(
                        text: 'Today',
                        icon: Icons.home_rounded,
                        enabled: false,
                        onTap: () {},
                      )
                    : menuItem(
                        text: 'Today',
                        icon: Icons.home_rounded,
                        enabled: true,
                        onTap: () {
                          Navigator.of(context).popAndPushNamed('/home');
                        },
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                (ModalRoute.of(context)!.settings.name == '/tasks')
                    ? menuItem(
                        text: 'Tasks',
                        icon: Icons.check_box_outlined,
                        enabled: false,
                        onTap: () {},
                      )
                    : menuItem(
                        text: 'Tasks',
                        icon: Icons.check_box_outlined,
                        enabled: true,
                        onTap: () {
                          Navigator.of(context).popAndPushNamed('/tasks');
                        },
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                (ModalRoute.of(context)!.settings.name == '/timetable')
                    ? menuItem(
                        text: 'Timetable',
                        icon: Icons.calendar_view_day_rounded,
                        enabled: false,
                        onTap: () {},
                      )
                    : menuItem(
                        text: 'Timetable',
                        icon: Icons.calendar_view_day_rounded,
                        enabled: true,
                        onTap: () {
                          Navigator.of(context).popAndPushNamed('/timetable');
                        },
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                (ModalRoute.of(context)!.settings.name == '/events')
                    ? menuItem(
                        text: 'Events',
                        icon: Icons.calendar_today_rounded,
                        enabled: false,
                        onTap: () {},
                      )
                    : menuItem(
                        text: 'Events',
                        icon: Icons.calendar_today_rounded,
                        enabled: true,
                        onTap: () {
                          Navigator.of(context).popAndPushNamed('/events');
                        },
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
  required VoidCallback onTap,
}) =>
    InkWell(
      onTap: onTap,
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

Widget menuItem({
  required String text,
  required IconData icon,
  required bool enabled,
  void Function()? onTap,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
    title: Text(
      text,
      style: TextStyle(
        color: enabled ? Colors.white : BuzzerColors.lightOrange,
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        fontFamily: 'Roboto',
      ),
    ),
    enabled: enabled,
    hoverColor: BuzzerColors.lightOrange,
    onTap: onTap,
  );
}
