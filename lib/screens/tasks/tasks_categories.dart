import 'package:buzzer/main.dart';
import 'package:buzzer/screens/tasks/tasks_viewmodel.dart';
import 'package:buzzer/viewmodels/categories_viewmodel.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/outlined_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TasksCategories extends StatefulWidget {
  const TasksCategories({Key? key}) : super(key: key);

  @override
  State<TasksCategories> createState() => _TasksCategoriesState();
}

class _TasksCategoriesState extends State<TasksCategories> {
  TasksViewModel model = TasksViewModel();
  String selectedCategory = 'None';

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();

    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: () => CategoriesViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: const AppBarWidget(title: 'Categories'),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ...model.categories.map((category) {
                        return Card(
                          color:
                              (selectedCategory.compareTo(category.name) == 0)
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
                                color: (selectedCategory
                                            .compareTo(category.name) ==
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
                              selectedCategory = category.name;
                            },
                          ),
                        );
                      })
                    ],
                  ),
                  OutlinedTextButtonWidget(
                    text: '+ Add Category',
                    onPressed: () {},
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

  // Future addTask() {
  //   return showDialog(context: context, builder: builder);
  // }
}
