import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.keyboardType,
    required this.textCapitalization,
    required this.onChannge,
    required this.validator,
    required this.borderRadius,
  }) : super(key: key);

  final String labelText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final Function(String) onChannge;
  final String? Function(String? value) validator;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      cursorColor: BuzzerColors.orange,
      validator: validator,
      style: const TextStyle(
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        hintText: labelText,
        border: OutlineInputBorder(borderRadius: borderRadius),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: BuzzerColors.grey),
        ),
        errorBorder: OutlineInputBorder(borderRadius: borderRadius),
      ),
      onChanged: onChannge,
      textCapitalization: textCapitalization,
    );
  }
}

class ValueTextFieldWidget extends StatelessWidget {
  const ValueTextFieldWidget({
    Key? key,
    required this.labelText,
    required this.defaultValue,
    required this.keyboardType,
    required this.textCapitalization,
    required this.onChannge,
    required this.validator,
    required this.borderRadius,
  }) : super(key: key);

  final String labelText;
  final String defaultValue;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final Function(String) onChannge;
  final String? Function(String?) validator;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: TextEditingController(text: defaultValue),
      keyboardType: keyboardType,
      cursorColor: BuzzerColors.orange,
      validator: validator,
      style: const TextStyle(
        fontSize: 15.0,
      ),
      decoration: InputDecoration(
        hintText: labelText,
        border: OutlineInputBorder(borderRadius: borderRadius),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: BuzzerColors.grey),
        ),
        errorBorder: OutlineInputBorder(borderRadius: borderRadius),
      ),
      onChanged: onChannge,
      textCapitalization: textCapitalization,
    );
  }
}
