import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/notifications.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/categories.dart';
import 'package:buzzer/screens/events/projects/project_tasks.dart';
import 'package:buzzer/screens/reminders.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  late String title = '';
  DateTime date = DateTime.now();
  late DateTime time = date.add(const Duration(hours: 1));
  late List<Task> tasks = [];

  String category = 'None';
  late String reminder = 'None';

  String _id() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomOptions(context, _onSave),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFieldWidget(
                  labelText: 'Project Name',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChannge: (value) {
                    title = value;
                  },
                  validator: (value) {
                    if (value != null && value.length > 20) {
                      return 'Maximum 20 characters';
                    }
                    return null;
                  },
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                Column(
                  children: <Widget>[
                    TextButtonRow(
                      label: 'Date',
                      text: DateFormat(
                        'd MMMM',
                      ).format(date),
                      icon: false,
                      onPressed: _selectDate,
                      borderRadius: const BorderRadius.all(Radius.zero),
                    ),
                    TextButtonRow(
                      label: 'Time',
                      text: DateFormat.Hm().format(time),
                      icon: false,
                      onPressed: _selectTime,
                      borderRadius: const BorderRadius.all(Radius.zero),
                    ),
                    TextButtonRow(
                      label: 'Category',
                      text: category,
                      icon: true,
                      onPressed: () {
                        _getCategory(context);
                      },
                      borderRadius: const BorderRadius.all(Radius.zero),
                    ),
                    TextButtonRow(
                      label: 'Reminder',
                      text: reminder,
                      icon: true,
                      onPressed: () {
                        _setReminder(context);
                      },
                      borderRadius: const BorderRadius.all(Radius.zero),
                    ),
                    TextButtonRow(
                      label: 'Tasks',
                      text: tasks.isEmpty ? 'Add' : '${tasks.length}',
                      icon: true,
                      onPressed: () {
                        _setTasks(context);
                      },
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setReminder(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReminderPicker(selectedReminder: reminder),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        reminder = result;
      });
    }
  }

  Future<void> _setTasks(BuildContext context) async {
    final List<Task>? results = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ProjectTasks(category: category, date: date, tasks: tasks),
      ),
    );

    if (!mounted) return;

    if (results != null) {
      setState(() {
        tasks = results;
      });
    }
  }

  void _onSave() {
    if (title != '') {
      final project = Project(
          _id(),
          title,
          category,
          DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          ),
          time,
          false,
          0.0);

      final tasksBox = Hive.box<Task>('tasks');
      project.tasks = HiveList(tasksBox);

      final box = Hive.box<Project>('projects');
      box.add(project);

      if (tasks.isNotEmpty) {
        for (var task in tasks) {
          tasksBox.add(task);
          project.tasks.add(task);
        }
      }

      final categoryBox = Hive.box<Category>('categories');
      final categories = categoryBox.values.toList().cast<Category>();

      final index = categories.indexWhere(
          (category) => category.name.compareTo(project.title) == 0);

      if (index == -1) {
        categoryBox.add(Category(name: title, uses: 1));
      } else {
        categories[index].uses++;
        categories[index].save();
      }

      switch (reminder) {
        case 'None':
          break;
        case '10 minutes before':
          NotificationClass().setReminder(project.id.hashCode, category, title,
              date.subtract(const Duration(minutes: 10)));
          break;
        case '30 minutes before':
          NotificationClass().setReminder(project.id.hashCode, category, title,
              date.subtract(const Duration(minutes: 30)));
          break;
        case '1 hour before':
          NotificationClass().setReminder(project.id.hashCode, category, title,
              date.subtract(const Duration(hours: 1)));
          break;
        case '2 hours before':
          NotificationClass().setReminder(project.id.hashCode, category, title,
              date.subtract(const Duration(hours: 2)));
          break;
        case 'One day before':
          NotificationClass().setReminder(project.id.hashCode, category, title,
              date.subtract(const Duration(days: 1)));
          break;
      }

      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project name must not be empty'),
        ),
      );
    }
  }

  Future _selectTime() async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(time);

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        time = DateTime(
          date.year,
          date.month,
          date.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        date = DateTime(
          date.year,
          date.month,
          date.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
  }

  Future _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate:
          DateTime(DateTime.now().add(const Duration(days: 365 * 4)).year),
    );

    if (selectedDate != null) {
      setState(() {
        date = selectedDate;
      });
    }
  }

  Future<void> _getCategory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CategoryPicker(
                selectedCategory: category,
              )),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        category = result;
      });
    }
  }
}
