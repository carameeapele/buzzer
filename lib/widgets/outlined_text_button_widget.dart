import 'package:flutter/material.dart';

class OutlinedTextButtonWidget extends StatelessWidget {
  const OutlinedTextButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 15.0,
        ),
      ),
      style: TextButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(7.0),
          ),
          side: BorderSide(
            color: color,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
