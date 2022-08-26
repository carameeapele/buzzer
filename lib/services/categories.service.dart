import 'package:buzzer/models/category_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

class CategoryService with ReactiveServiceMixin {
  final _categories = ReactiveValue<List<Category>>(
    Hive.box('categories').get(
      'categories',
      defaultValue: [Category(name: 'None', uses: 1)],
    ).cast<Category>(),
  );

  List<Category> get categories => _categories.value;

  CategoryService() {
    listenToReactiveValues([_categories]);
  }

  void _addToHive() {
    Hive.box('categories').put('categories', _categories);
  }

  void addCategory(String name) {
    _categories.value.add(Category(name: name, uses: 1));

    _addToHive();
    notifyListeners();
  }

  void deleteCategory() {
    final index =
        _categories.value.indexWhere((category) => category.uses == 0);

    if (index != -1) {
      _categories.value.removeAt(index);

      _addToHive();
      notifyListeners();
    }
  }

  void addUse(String name) {
    final index = _categories.value
        .indexWhere((category) => category.name.compareTo(name) == 0);

    if (index != -1) {
      _categories.value[index].uses++;
    }
  }
}
