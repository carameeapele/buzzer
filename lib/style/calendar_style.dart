import 'package:buzzer/main.dart';
import 'package:buzzer/models/buzz_user.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

CalendarStyle calendarStyle = CalendarStyle(
  outsideDaysVisible: true,
  weekendTextStyle: TextStyle(
    color: BuzzerColors.lightOrange,
    fontFamily: 'Roboto',
    fontSize: 16.0,
  ),
  defaultTextStyle: const TextStyle(
    color: Colors.black,
    fontFamily: 'Roboto',
    fontSize: 16.0,
  ),
  outsideTextStyle: TextStyle(
    color: BuzzerColors.grey,
    fontFamily: 'Roboto',
    fontSize: 16.0,
  ),
  todayTextStyle: TextStyle(
    color: BuzzerColors.orange,
    fontFamily: 'Roboto',
    fontSize: 16.0,
  ),
);
