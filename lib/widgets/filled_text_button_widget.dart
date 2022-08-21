import 'package:flutter/material.dart';

class FilledTextButtonWidget extends StatelessWidget {
  const FilledTextButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
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
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          icon
              ? const SizedBox(
                  width: 3.0,
                )
              : const SizedBox(),
          icon
              ? const Icon(
                  Icons.add,
                  size: 18.0,
                  color: Colors.black,
                )
              : const SizedBox(),
        ],
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
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
