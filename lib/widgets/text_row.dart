import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextButtonRow extends StatelessWidget {
  const TextButtonRow({
    Key? key,
    required this.label,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.borderRadius,
  }) : super(key: key);

  final String label;
  final String text;
  final bool icon;
  final void Function() onPressed;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: BuzzerColors.grey,
        ),
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
          SmallFilledTextButton(
            onPressed: onPressed,
            text: text,
            icon: icon,
            backgroundColor: BuzzerColors.lightGrey,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class TextFieldRow extends StatelessWidget {
  const TextFieldRow({
    Key? key,
    required this.label,
    required this.defaultValue,
    required this.maxLines,
    required this.onChannge,
    required this.borderRadius,
  }) : super(key: key);

  final String label;
  final String defaultValue;
  final int maxLines;
  final Function(String) onChannge;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: BuzzerColors.grey,
        ),
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            width: 150.0,
            child: TextField(
              textAlign: TextAlign.end,
              inputFormatters: [LengthLimitingTextInputFormatter(maxLines)],
              controller: TextEditingController(text: defaultValue),
              style: const TextStyle(
                fontSize: 15.0,
              ),
              cursorColor: BuzzerColors.orange,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                focusedBorder: InputBorder.none,
                fillColor: Colors.transparent,
                hintText: label,
                border: InputBorder.none,
              ),
              onChanged: onChannge,
            ),
          ),
        ],
      ),
    );
  }
}
