import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextStyle field = TextStyle(
    fontSize: 12.0,
    fontFamily: 'Roboto',
    letterSpacing: 1.0,
    color: BuzzerColors.grey,
  );

  @override
  Widget build(BuildContext context) {
    final preferences = Hive.box('preferences');
    bool? darkMode = preferences.get('darkMode', defaultValue: true);
    bool? weekendDays = preferences.get('weekendDays', defaultValue: false);
    int? repeatAfter = preferences.get('repeatAfter', defaultValue: 1);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      endDrawer: const MenuDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Checkbox(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                      preferences.put('darkMode', darkMode);
                    });
                  },
                )
              ],
            ),
            FilledTextButtonWidget(
              onPressed: () {},
              text: 'Reset Buzzer',
              icon: false,
              backgroundColor: BuzzerColors.lightGrey,
              textColor: Colors.black,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Timetable'.toUpperCase(),
              style: field,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Weekend days',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Checkbox(
                  value: weekendDays,
                  onChanged: (value) {
                    setState(() {
                      weekendDays = value;
                      preferences.put('weekendDays', value);
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Repeat after',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Card(
                  elevation: 0.0,
                  color: BuzzerColors.lightGrey,
                  child: ButtonBar(
                    buttonPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    children: <Widget>[
                      SizedBox(
                        width: 40.0,
                        height: 30.0,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              repeatAfter = 1;
                              preferences.put('repeatAfter', repeatAfter);
                            });
                          },
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: (repeatAfter == 1)
                                  ? BuzzerColors.orange
                                  : Colors.black,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            primary: BuzzerColors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                        height: 30.0,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              repeatAfter = 2;
                              preferences.put('repeatAfter', repeatAfter);
                            });
                          },
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: (repeatAfter == 2)
                                  ? BuzzerColors.orange
                                  : Colors.black,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            primary: BuzzerColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Tasks'.toUpperCase(),
              style: field,
            ),
            const Divider(),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Events'.toUpperCase(),
              style: field,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
