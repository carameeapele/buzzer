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
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          wordSpacing: 3.0,
        ),
      ),
      titleSpacing: 0.0,
      actions: <Widget>[
        Material(
          color: Colors.white,
          child: Center(
            child: Ink(
              decoration: ShapeDecoration(
                color: BuzzerColors.orange,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.0),
                  ),
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
