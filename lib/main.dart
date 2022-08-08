import 'package:buzzer/models/user_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BuzzUserAdapter());
  await Hive.openBox<BuzzUser>('users');

  runApp(const ProviderScope(child: MyApp()));
}

final firebaseInitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
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
  static var lightGrey = const Color(0xffF0F0F0);
  static var grey = const Color.fromARGB(255, 160, 160, 160);
  static var darkGrey = const Color(0xff464646);
  static var lightOrange = const Color(0xffFFB58B);
  static var orange = const Color(0xffDB6622);
}
