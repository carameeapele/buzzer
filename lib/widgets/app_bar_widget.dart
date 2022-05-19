import 'package:buzzer/icons/icons.dart';
import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  // VoidCallback? add;
  AppBarWidget({
    Key? key,
    required this.title,
    // required this.add,
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
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
          fontSize: 25.0,
          fontWeight: FontWeight.w900,
        ),
      ),
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        //icon: const Icon(Buzzer.menuIcon),
        icon: const Icon(Icons.menu_rounded),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          color: BuzzerColors.orange,
        ),
      ],
    );
  }
}
