import 'package:buzzer/main.dart';
import 'package:buzzer/screens/authenticate/signin.dart';
import 'package:buzzer/screens/authenticate/signup.dart';
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
      body: Column(
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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignIn(),
              ));
            },
            child: const Text(
              'Sign in to account',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              primary: Colors.deepOrange,
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignUp(),
              ));
            },
            child: const Text(
              'Create your account',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            style: TextButton.styleFrom(
              primary: BuzzerColors.lightGrey,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
