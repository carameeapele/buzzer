import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/tasks/categories.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late String title;
  DateTime date = DateTime.now();
  late DateTime time =
      DateTime(date.year, date.month, date.day, date.hour + 1, 0);

  String category = 'None';
  String details = '';

  String _id() {
    final now = DateTime.now();
    return now.millisecondsSinceEpoch.toString();
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
                  labelText: 'Task Name',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChannge: (value) {
                    title = value;
                  },
                  validator: (value) {
                    if (value != null && value.length > 20) {
                      return 'Maximum 20 characters';
                    } else {
                      return null;
                    }
                  },
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                TextFieldWidget(
                  labelText: 'Details',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    details = value;
                  },
                  validator: (value) {
                    return null;
                  },
                  borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10.0)),
                ),
                TextButtonRow(
                  label: 'Date',
                  text: DateFormat(
                    'd MMMM',
                  ).format(date),
                  icon: false,
                  onPressed: selectDate,
                ),
                TextButtonRow(
                  label: 'Time',
                  text: DateFormat.Hm().format(time),
                  icon: false,
                  onPressed: selectTime,
                ),
                TextButtonRow(
                  label: 'Category',
                  text: category,
                  icon: true,
                  onPressed: () {
                    _getCategory(context);
                  },
                ),
                TextButtonRow(
                  label: 'Reminder',
                  text: '1 hour before',
                  icon: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (title.isNotEmpty) {
      final task = Task(
        id: _id(),
        title: title,
        date: DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ),
        time: time,
        category: category,
        details: details,
        complete: false,
      );

      final box = Hive.box<Task>('tasks');
      box.add(task);

      Navigator.of(context).pop();
    }
  }

  Future selectTime() async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(time).replacing(minute: 0);

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
      });
    }
  }

  Future<void> _getCategory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPicker(selectedCategory: category),
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
      initialDate: DateTime.now(),
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
