import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
import 'package:buzzer/widgets/outlined_text_button_widget.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 34,
                  height: 31,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/media/buzzer_icon.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Buzzer',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Organized\nProcrastination',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 35,
              ),
              textAlign: TextAlign.center,
            ),
            FilledTextButtonWidget(
              text: 'Sign in to account',
              function: () {
                Navigator.of(context).popAndPushNamed('/signin');
              },
              backgroundColor: BuzzerColors.orange,
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 7.0,
            ),
            OutlinedTextButtonWidget(
              text: 'Create an account',
              function: () {
                Navigator.of(context).popAndPushNamed('/signup');
              },
              color: BuzzerColors.orange,
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              'Made For Students By Students',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
