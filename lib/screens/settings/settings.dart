import 'package:buzzer/main.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const AppBarWidget(
        title: 'Settings',
      ),
      endDrawer: const MenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Timetable',
              style: subtitleTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Weekend days',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  fillColor: MaterialStateProperty.all(BuzzerColors.orange),
                  checkColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.7),
                    ),
                  ),
                )
              ],
            ),
            FilledTextButtonWidget(
              onPressed: () {},
              text: 'Reset Timetable',
              icon: false,
              backgroundColor: Colors.white,
              textColor: BuzzerColors.orange,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              'Tasks',
              style: subtitleTextStyle,
            ),
            FilledTextButtonWidget(
              onPressed: () {},
              text: 'Reset Tasks',
              icon: false,
              backgroundColor: Colors.white,
              textColor: BuzzerColors.orange,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              'Events',
              style: subtitleTextStyle,
            ),
            FilledTextButtonWidget(
              onPressed: () {},
              text: 'Reset Events',
              icon: false,
              backgroundColor: Colors.white,
              textColor: BuzzerColors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
