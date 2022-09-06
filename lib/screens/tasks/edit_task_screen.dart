import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/tasks/categories.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late String title = widget.task.title;
  late DateTime date = widget.task.date;
  late DateTime time = widget.task.time;
  late String category = widget.task.category;
  late String details = widget.task.details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomOptions(context, _editTask),
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
                  labelText: 'Task Name',
                  defaultValue: title,
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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                ),
                ValueTextFieldWidget(
                  labelText: 'Details',
                  defaultValue: details,
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
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 5.0, 10.0),
                  child: Column(
                    children: [
                      TextButtonRow(
                        label: 'Date',
                        text: DateFormat(
                          'd MMMM',
                        ).format(date),
                        icon: false,
                        onPressed: _selectDate,
                      ),
                      TextButtonRow(
                        label: 'Time',
                        text: DateFormat.Hm().format(time),
                        icon: false,
                        onPressed: _selectTime,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _selectTime() async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(time);

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input,
      hourLabelText: initialTime.hour.toString(),
      minuteLabelText: initialTime.minute.toString(),
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
          builder: (context) => CategoryPicker(selectedCategory: category)),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        category = result;
      });
    }
  }

  Future _selectDate() async {
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

  void _editTask() {
    widget.task.title = title;
    widget.task.date = date;
    widget.task.time = time;
    widget.task.category = category;
    widget.task.details = details;

    widget.task.save();
    Navigator.of(context).pop();
  }
}
