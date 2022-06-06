import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: MyApp()));
}

final firebaseInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  //SharedPreferences sharedPrefs;
  const MyApp({
    Key? key,
    //required this.sharedPrefs,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseInitializerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buzzer',
      theme: ThemeData(
        primaryColor: BuzzerColors.orange,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: initialize.when(
        data: (data) {
          return const Wrapper();
        },
        error: (Object error, StackTrace? stackTrace) {
          return Container();
        },
        loading: () {
          return const Loading();
        },
      ),
    );
  }
}

class BuzzerColors {
  static var lightGrey = const Color.fromARGB(255, 240, 240, 240);
  static var grey = const Color(0xffC4C4C4);
  static var darkGrey = const Color(0xff464646);
  static var lightOrange = const Color(0xffFFB58B);
  static var orange = const Color.fromARGB(255, 228, 129, 72);
}
