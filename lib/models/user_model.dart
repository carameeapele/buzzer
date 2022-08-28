import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class BuzzUser extends HiveObject {
  @HiveField(0)
  late String userId;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String email;

  BuzzUser({
    required this.userId,
  });
}
