import 'package:buzzer/services/categories.service.dart';
import 'package:buzzer/services/tasks.service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupLocator() {
  getIt.registerLazySingleton(() => TasksService());
  getIt.registerLazySingleton(() => CategoryService());
}
