import 'package:buzzer/main.dart';
import 'package:buzzer/style/text_style.dart';
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
