import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:flutter/material.dart';

class TextButtonRow extends StatelessWidget {
  const TextButtonRow({
    Key? key,
    required this.label,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final String text;
  final bool icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
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
    );
  }
}

class TextFieldRow extends StatelessWidget {
  const TextFieldRow({
    Key? key,
    required this.label,
    required this.defaultValue,
    required this.onChannge,
  }) : super(key: key);

  final String label;
  final String defaultValue;
  final Function(String) onChannge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: 15.0,
          ),
        ),
        SizedBox(
          width: 80.0,
          child: TextFormField(
            textDirection: TextDirection.rtl,
            controller: TextEditingController(text: defaultValue),
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15.0,
            ),
            cursorColor: BuzzerColors.orange,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 12.0,
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                borderSide: BorderSide(
                  color: BuzzerColors.grey,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                borderSide: BorderSide(
                  color: BuzzerColors.orange,
                  width: 2.0,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 168, 28, 19),
                  width: 2.0,
                ),
              ),
            ),
            onChanged: onChannge,
          ),
        ),
      ],
    );
  }
}
