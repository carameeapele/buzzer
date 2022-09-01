import 'package:buzzer/main.dart';
import 'package:buzzer/style/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      letterSpacing: 1.0,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontSize: 22.0,
      fontWeight: FontWeight.w900,
      wordSpacing: 3.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  primaryColor: BuzzerColors.orange,
  backgroundColor: BuzzerColors.darkGrey,
  scaffoldBackgroundColor: BuzzerColors.darkGrey,
  fontFamily: 'Roboto',
  dividerTheme: DividerThemeData(
    color: BuzzerColors.grey,
    thickness: 2.0,
    space: 40.0,
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(BuzzerColors.darkGrey),
    fillColor: MaterialStateProperty.all(BuzzerColors.orange),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(2.7),
      ),
    ),
  ),
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: BuzzerColors.orange,
    onPrimary: Colors.white,
    secondary: BuzzerColors.grey,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: BuzzerColors.darkGrey,
    onBackground: Colors.white,
    surface: BuzzerColors.darkGrey,
    onSurface: Colors.white,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.white,
    unselectedLabelColor: BuzzerColors.grey,
  ),
);

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      letterSpacing: 1.0,
      color: Colors.black,
      fontFamily: 'Roboto',
      fontSize: 22.0,
      fontWeight: FontWeight.w900,
      wordSpacing: 3.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  primaryColor: BuzzerColors.orange,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto',
  dividerTheme: DividerThemeData(
    color: BuzzerColors.lightGrey,
    thickness: 2.0,
    space: 40.0,
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(BuzzerColors.orange),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(2.7),
      ),
    ),
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: BuzzerColors.orange,
    onPrimary: Colors.white,
    secondary: BuzzerColors.lightGrey,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: BuzzerColors.lightGrey,
    onBackground: Colors.black,
    surface: BuzzerColors.lightGrey,
    onSurface: Colors.black,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: BuzzerColors.grey,
  ),
);
