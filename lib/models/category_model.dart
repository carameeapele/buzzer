import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
class Category extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  int uses = 0;

  Category({
    required this.name,
    required this.uses,
  });
}
