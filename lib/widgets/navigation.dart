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
                  enabled: false,
                  onTap: () {},
                )
              : menuItem(
                  text: 'Settings',
                  enabled: true,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/settings');
                  },
                ),
          const SizedBox(
            height: 20.0,
          ),
          (ModalRoute.of(context)!.settings.name == '/events')
              ? menuItem(
                  text: 'Events',
                  enabled: false,
                  onTap: () {},
                )
              : menuItem(
                  text: 'Events',
                  enabled: true,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/events');
                  },
                ),
          const SizedBox(
            height: 20.0,
          ),
          (ModalRoute.of(context)!.settings.name == '/timetable')
              ? menuItem(
                  text: 'Timetable',
                  enabled: false,
                  onTap: () {},
                )
              : menuItem(
                  text: 'Timetable',
                  enabled: true,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/timetable');
                  },
                ),
          const SizedBox(
            height: 20.0,
          ),
          (ModalRoute.of(context)!.settings.name?.compareTo('/tasks') == 0)
              ? menuItem(
                  text: 'Tasks',
                  enabled: false,
                  onTap: () {},
                )
              : menuItem(
                  text: 'Tasks',
                  enabled: true,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/tasks');
                  },
                ),
          const SizedBox(
            height: 20.0,
          ),
          (ModalRoute.of(context)!.settings.name == '/')
              ? menuItem(
                  text: 'Today',
                  enabled: false,
                  onTap: () {},
                )
              : menuItem(
                  text: 'Today',
                  enabled: true,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}

Widget menuItem({
  required String text,
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
