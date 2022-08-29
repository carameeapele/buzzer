import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/small_filled_text_button.dart';
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
    required this.onChannge,
  }) : super(key: key);

  final String label;
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
        TextFieldWidget(
          labelText: '',
          keyboardType: TextInputType.text,
          obscureText: false,
          textCapitalization: TextCapitalization.none,
          onChannge: onChannge,
        )
      ],
    );
  }
}
