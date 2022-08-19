import 'dart:ffi';

import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

class SmallFilledTextButton extends StatelessWidget {
  const SmallFilledTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;
  final bool icon;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Roboto',
              ),
            ),
            icon
                ? const SizedBox(
                    width: 5.0,
                  )
                : const SizedBox(),
            icon
                ? const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.0,
                  )
                : const SizedBox(),
          ],
        ),
        style: TextButton.styleFrom(
          primary: BuzzerColors.darkGrey,
          backgroundColor: backgroundColor,
        ));
  }
}
