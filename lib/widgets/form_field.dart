import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.labetText,
    required this.validator,
    required this.onChannge,
  }) : super(key: key);

  final String labetText;
  final VoidCallback? validator;
  final VoidCallback? onChannge;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labetText,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7.0)),
          borderSide: BorderSide(
            color: BuzzerColors.grey,
            width: 2.0,
          ),
        ),
        labelStyle: TextStyle(
          color: BuzzerColors.grey,
          fontFamily: 'Roboto',
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7.0)),
          borderSide: BorderSide(
            color: BuzzerColors.orange,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}

InputDecoration textInputDecoration = InputDecoration(
  labelText: 'Email',
  border: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
    borderSide: BorderSide(
      color: BuzzerColors.grey,
      width: 2.0,
    ),
  ),
  labelStyle: TextStyle(
    color: BuzzerColors.grey,
    fontSize: 14.0,
    fontFamily: 'Roboto',
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
    borderSide: BorderSide(
      color: BuzzerColors.orange,
      width: 2.0,
    ),
  ),
);
