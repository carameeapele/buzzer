import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

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
