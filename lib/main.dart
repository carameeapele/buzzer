import 'package:buzzer/models/buzz_user.dart';
import 'package:buzzer/screens/wrapper.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //SharedPreferences sharedPrefs;
  MyApp({
    Key? key,
    //required this.sharedPrefs,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<BuzzUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Buzzer',
        theme: ThemeData(
          primaryColor: BuzzerColors.orange,
          backgroundColor: Colors.white,
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        // initialRoute: '/signin',
        // routes: {
        //   '/signin': (context) => const SignIn(),
        //   '/signup': (context) => const SignUp(),
        //   '/home': (context) => const Home(),
        // },
      ),
    );
  }
}

class BuzzerColors {
  static var lightGrey = const Color(0xffF0F0F0);
  static var grey = const Color(0xffC4C4C4);
  static var darkGrey = const Color(0xff464646);
  static var lightOrange = const Color(0xffFFB58B);
  static var orange = const Color(0xffD76626);
}
