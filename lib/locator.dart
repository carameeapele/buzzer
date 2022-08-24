import 'package:buzzer/services/tasks.service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupLocator() {
  getIt.registerLazySingleton(() => TasksService());
}
