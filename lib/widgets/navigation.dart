import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 180.0,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20.0),
        ),
      ),
      backgroundColor: BuzzerColors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          (ModalRoute.of(context)!.settings.name == '/settings')
              ? menuItem(
                  text: 'Settings',
                  icon: Icons.calendar_today_rounded,
                  enabled: false,
                  onTap: () {},
                )
              : menuItem(
                  text: 'Settings',
                  icon: Icons.calendar_today_rounded,
                  enabled: true,
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/settings');
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
          (ModalRoute.of(context)!.settings.name == '/')
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
                    Navigator.of(context).popAndPushNamed('/');
                  },
                ),
          const SizedBox(
            height: 40.0,
          ),
        ],
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
      textAlign: TextAlign.end,
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
