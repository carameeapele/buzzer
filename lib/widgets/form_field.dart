import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.labetText,
    required this.keyboardType,
    required this.obscureText,
    required this.onChannge,
  }) : super(key: key);

  final String labetText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String) onChannge;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: BuzzerColors.orange,
      validator: (String? value) {
        return (value!.isEmpty)
            ? 'Please enter your ${labetText.toLowerCase()}'
            : null;
      },
      decoration: InputDecoration(
        labelText: labetText,
        floatingLabelStyle: TextStyle(
          color: BuzzerColors.orange,
        ),
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
      onChanged: onChannge,
      obscureText: obscureText,
    );
  }
}