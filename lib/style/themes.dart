import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[800],
    contentTextStyle: const TextStyle(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 15.0,
    ),
    filled: true,
    fillColor: Colors.grey[800],
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: BuzzerColors.grey,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 168, 28, 19),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(color: Colors.white),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.grey[800],
    elevation: 0.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    textColor: Colors.white,
    collapsedTextColor: Colors.white,
  ),
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
    space: 2.0,
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
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey[350],
    contentTextStyle: const TextStyle(color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 15.0,
    ),
    filled: true,
    fillColor: BuzzerColors.lightGrey,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: BuzzerColors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: BuzzerColors.grey,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 168, 28, 19),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(color: Colors.black),
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    textColor: Colors.black,
    collapsedTextColor: Colors.black,
  ),
  cardTheme: CardTheme(
    color: BuzzerColors.lightGrey,
    elevation: 0.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  ),
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
