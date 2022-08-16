import 'package:flutter/material.dart';

class FilledTextButtonWidget extends StatelessWidget {
  const FilledTextButtonWidget({
    Key? key,
    required this.text,
    required this.function,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  final String text;
  final VoidCallback? function;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
      ),
    );
  }
}