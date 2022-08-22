import 'package:buzzer/style/text_style.dart';
import 'package:flutter/material.dart';

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
