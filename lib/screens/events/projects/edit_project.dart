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

class EditProject extends StatefulWidget {
  const EditProject({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  late String title = widget.project.title;
  late DateTime date = widget.project.date;
  late DateTime time = widget.project.time;
  late String category = widget.project.category;
  late HiveList tasksList = widget.project.tasks;
  late List<Task> tasks = tasksList.toList().cast<Task>();
  late List<Task> newTasks = [];

  late String reminder = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomOptions(context, _editProject),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ValueTextFieldWidget(
                  labelText: 'Project Name',
                  defaultValue: title,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChannge: (value) {
                    title = value;
                  },
                  validator: (value) {
                    return null;
                  },
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                TextButtonRow(
                  label: 'Date',
                  text: DateFormat(
                    'd MMMM',
                  ).format(date),
                  icon: false,
                  onPressed: selectDate,
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'Time',
                  text: DateFormat.Hm().format(time),
                  icon: false,
                  onPressed: selectTime,
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
                  onPressed: () {},
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'Tasks',
                  text: newTasks.isEmpty ? 'Add' : '${newTasks.length}',
                  icon: true,
                  onPressed: () {
                    _setTasks();
                  },
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setReminder() async {
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

  void _editProject() {
    widget.project.title = title;
    widget.project.date = date;
    widget.project.time = time;
    widget.project.category = category;

    final tasksBox = Hive.box<Task>('tasks');

    if (newTasks.isNotEmpty) {
      for (var newTask in newTasks) {
        if (!tasks.contains(newTask)) {
          tasksBox.add(newTask);
          widget.project.tasks.add(newTask);
        }
      }
    }

    widget.project.save();
    Navigator.of(context).pop();
  }

  Future<void> _setTasks() async {
    newTasks.addAll(tasks);

    final List<Task>? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ProjectTasks(category: category, date: date, tasks: newTasks),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        newTasks = result;
      });
    }
  }

  Future selectTime() async {
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

  Future<void> _getCategory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPicker(
          selectedCategory: category,
        ),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        category = result;
      });
    }
  }

  Future selectDate() async {
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
}
