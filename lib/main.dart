import 'package:buzzer/adapters/category.adapter.dart';
import 'package:buzzer/adapters/course.adapter.dart';
import 'package:buzzer/adapters/datetime.adapter.dart';
import 'package:buzzer/adapters/exam.adapter.dart';
import 'package:buzzer/adapters/project.adapter.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/adapters/task.adapter.dart';
import 'package:buzzer/screens/events/exams/add_exam.dart';
import 'package:buzzer/screens/events/projects/add_project.dart';
import 'package:buzzer/screens/events/events.dart';
import 'package:buzzer/screens/home/home.dart';
import 'package:buzzer/screens/settings/account_settings.dart';
import 'package:buzzer/screens/settings/general_settings.dart';
import 'package:buzzer/screens/settings/settings.dart';
import 'package:buzzer/screens/tasks/add_task_screen.dart';
import 'package:buzzer/screens/tasks/tasks.dart';
import 'package:buzzer/screens/categories.dart';
import 'package:buzzer/screens/timetable/timetable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();

  Hive.registerAdapter(DateTimeAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(ExamAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox<Task>('tasks');
  await Hive.openBox<Category>('categories');
  await Hive.openBox<Exam>('exams');
  await Hive.openBox<Project>('projects');
  await Hive.openBox<Course>('classes');

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buzzer',
      theme: ThemeData(
        primaryColor: BuzzerColors.orange,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      // try adding a splash screen
      home: const Home(),
      routes: {
        '/events': (context) => const EventsScreen(),
        '/add_exam': (context) => const AddExamScreen(),
        '/add_project': (context) => const AddProjectScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/add_task': (context) => const AddTaskScreen(),
        '/tasks_category': (context) => const Categories(),
        '/timetable': (context) => const TimetableScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/account_settings': (context) => const AccountSettings(),
        '/general_settings': (context) => const GeneralSettings(),
      },
    );
  }
}

class BuzzerColors {
  static var lightGrey = const Color(0xffF0F0F0);
  static var grey = const Color.fromARGB(255, 160, 160, 160);
  static var darkGrey = const Color(0xff464646);
  static var lightOrange = const Color(0xffFFB58B);
  static var orange = const Color(0xffFF823C);
}
