import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.keyboardType,
    required this.obscureText,
    required this.textCapitalization,
    required this.onChannge,
  }) : super(key: key);

  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final Function(String) onChannge;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: BuzzerColors.orange,
      validator: (String? value) {
        return (value!.isEmpty)
            ? 'Please enter your ${labelText.toLowerCase()}'
            : null;
      },
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 12.0,
        ),
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
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 168, 28, 19),
            width: 2.0,
          ),
        ),
      ),
      onChanged: onChannge,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
    );
  }
}
