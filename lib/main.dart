import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buzzer',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        backgroundColor: Colors.white,
      ),
      home: Wrapper(),
    );
  }
}

class ColorPallete {
  static var lightGrey = const Color(0xffF0F0F0);
  static var grey = const Color(0xffD0D0D0);
  static var darkGrey = const Color(0xff464646);
}
