import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  border: const UnderlineInputBorder(),
  labelStyle: TextStyle(
    color: BuzzerColors.grey,
    fontSize: 14.0,
    fontFamily: 'Roboto',
  ),
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.deepOrange,
    ),
  ),
);
