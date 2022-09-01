import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

// FILLED TEXT BUTTON

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
              fontSize: 15.0,
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

// OUTLINED TEXT BUTTON

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

// SMALL FILLED TEXT BUTTON

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
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.0,
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
          padding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 0.0,
          ),
        ));
  }
}

// SPACER BUTTON

class SpacerButton extends StatelessWidget {
  const SpacerButton({
    required this.text,
    required this.buttonText,
    required this.function,
    Key? key,
  }) : super(key: key);

  final String text;
  final String buttonText;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Spacer(),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 13.0,
          ),
        ),
        TextButton(
          onPressed: function,
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13.0,
              color: BuzzerColors.orange,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
