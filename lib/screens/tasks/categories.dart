import 'package:buzzer/main.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  final String selectedCategory;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  late String newCategoryName;
  late String selectedCategory = widget.selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Category>>(
      valueListenable: Hive.box<Category>('categories').listenable(),
      builder: (context, box, widget) {
        final categories = box.values.toList().cast<Category>();
        categories.removeWhere((category) => category.uses < 1);

        return Scaffold(
          appBar: AppBar(title: const Text('Categories')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories[index];

                      return customCard(
                        ListTile(
                          dense: true,
                          title: Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          trailing:
                              (selectedCategory.compareTo(category.name) == 0)
                                  ? const Icon(
                                      Icons.check,
                                      size: 20.0,
                                      color: Colors.white,
                                    )
                                  : null,
                          onTap: () {
                            setState(() {
                              selectedCategory = category.name;
                              Navigator.pop(context, selectedCategory);
                            });
                          },
                        ),
                        false,
                      );
                    },
                  ),
                  OutlinedTextButtonWidget(
                    text: '+ Add Category',
                    onPressed: () {
                      _addCategory();
                    },
                    color: BuzzerColors.orange,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future _addCategory() {
    return showDialog(
      context: context,
      builder: (contex) => AlertDialog(
        content: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFieldWidget(
            keyboardType: TextInputType.text,
            labelText: 'Category Name',
            textCapitalization: TextCapitalization.words,
            onChannge: (value) {
              newCategoryName = value;
            },
            validator: (value) {
              if (value != null && value.length > 25) {
                return 'Maximum 25 characters';
              }
              return null;
            },
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (newCategoryName.length < 25) {
                final category = Category(name: newCategoryName, uses: 1);
                final box = Hive.box<Category>('categories');
                final categories = box.values.toList().cast<Category>();

                final index = categories.indexWhere(
                    (element) => element.name.compareTo(category.name) == 0);

                if (index == -1) {
                  box.add(category);
                  selectedCategory = category.name;
                }

                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: Text(
              'Add',
              style: TextStyle(
                color: BuzzerColors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
