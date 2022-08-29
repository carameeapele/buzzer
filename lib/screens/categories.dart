import 'package:buzzer/main.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/outlined_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late String newCategoryName;
  late String selectedCategory = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Categories'),
      body: ValueListenableBuilder<Box<Category>>(
        valueListenable: Hive.box<Category>('categories').listenable(),
        builder: (context, box, widget) {
          final categories = box.values.toList().cast<Category>();

          return Padding(
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

                      return Card(
                        color: (selectedCategory.compareTo(category.name) == 0)
                            ? BuzzerColors.orange
                            : BuzzerColors.lightGrey,
                        elevation: 0.0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          title: Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 15.0,
                              color:
                                  (selectedCategory.compareTo(category.name) ==
                                          0)
                                      ? Colors.white
                                      : Colors.black,
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
                      );
                    },
                  ),
                  OutlinedTextButtonWidget(
                    text: '+ Add Category',
                    onPressed: () {
                      addCategory();
                    },
                    color: BuzzerColors.orange,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future addCategory() {
    return showDialog(
      context: context,
      builder: (contex) => AlertDialog(
        content: TextFieldWidget(
          keyboardType: TextInputType.text,
          labelText: 'Category Name',
          obscureText: false,
          textCapitalization: TextCapitalization.words,
          onChannge: (value) {
            newCategoryName = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              final category = Category(name: newCategoryName, uses: 1);
              final box = Hive.box<Category>('categories');
              box.add(category);

              Navigator.of(context, rootNavigator: true).pop();
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
