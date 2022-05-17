import 'package:buzzer/models/buzz_user.dart';
import 'package:buzzer/screens/authenticate/authenticate.dart';
import 'package:buzzer/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BuzzUser>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
