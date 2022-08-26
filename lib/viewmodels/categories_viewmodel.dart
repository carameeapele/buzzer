import 'package:buzzer/locator.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/services/categories.service.dart';
import 'package:stacked/stacked.dart';

class CategoriesViewModel extends ReactiveViewModel {
  final _categoriesService = getIt<CategoryService>();

  late final deleteCategory = _categoriesService.deleteCategory;

  List<Category> get categories => _categoriesService.categories;

  void addCategory(String name) {
    _categoriesService.addCategory(name);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_categoriesService];
}
