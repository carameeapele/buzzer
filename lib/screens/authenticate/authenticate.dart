import 'package:buzzer/main.dart';
import 'package:buzzer/screens/authenticate/signin.dart';
import 'package:buzzer/screens/authenticate/signup.dart';
import 'package:buzzer/widgets/text_button_widget.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  void buttonFunction(BuildContext context, String path) {
    Navigator.of(context).pop();
    switch (path) {
      case 'signin':
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignIn(),
        ));
        break;
      case 'signup':
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignUp(),
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Organized\nProcrastination',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Made For Students\nBy Students',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 70.0,
            ),
            TextButtonWidget(
              text: 'Sign in to account',
              function: () => buttonFunction(context, 'signin'),
              backgroundColor: BuzzerColors.orange,
              textColor: Colors.white,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButtonWidget(
              text: 'Create an account',
              function: () => buttonFunction(context, 'signup'),
              backgroundColor: BuzzerColors.lightGrey,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
