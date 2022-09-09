import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/models/notifications.dart';
import 'package:buzzer/screens/categories.dart';
import 'package:buzzer/screens/reminders.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class AddExamScreen extends StatefulWidget {
  const AddExamScreen({Key? key}) : super(key: key);

  @override
  State<AddExamScreen> createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  late String title = '';
  DateTime date = DateTime.now();
  late DateTime time = date.add(const Duration(hours: 1));

  String category = 'None';
  String details = '';
  String room = '';
  String building = '';
  String reminder = 'None';

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
                  labelText: 'Exam Name',
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
                  borderRadius: const BorderRadius.all(Radius.zero),
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
                TextFieldRow(
                  label: 'Building',
                  maxLines: 20,
                  defaultValue: building,
                  onChannge: (value) {
                    building = value.trim();
                  },
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextFieldRow(
                  label: 'Room',
                  maxLines: 6,
                  defaultValue: room,
                  onChannge: (value) {
                    room = value.trim();
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

  void _onSave() {
    if (title.isNotEmpty) {
      final exam = Exam(
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
        room: room,
        building: building,
      );

      final box = Hive.box<Exam>('exams');
      box.add(exam);

      final categoryBox = Hive.box<Category>('categories');
      final categories = categoryBox.values.toList().cast<Category>();

      final index = categories.indexWhere(
          (category) => category.name.compareTo(exam.category) == 0);

      if (index != -1) {
        categories[index].uses++;
        categories[index].save();
      }

      switch (reminder) {
        case 'None':
          break;
        case '10 minutes before':
          NotificationClass().setReminder(
              0, category, title, date.subtract(const Duration(minutes: 10)));
          break;
        case '30 minutes before':
          NotificationClass().setReminder(
              0, category, title, date.subtract(const Duration(minutes: 30)));
          break;
        case '1 hour before':
          NotificationClass().setReminder(
              0, category, title, date.subtract(const Duration(hours: 1)));
          break;
        case '2 hours before':
          NotificationClass().setReminder(
              0, category, title, date.subtract(const Duration(hours: 2)));
          break;
        case 'One day before':
          NotificationClass().setReminder(
              0, category, title, date.subtract(const Duration(days: 1)));
          break;
      }

      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Exam name must not be empty'),
        ),
      );
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

        date = DateTime(date.year, date.month, date.day, selectedTime.hour,
            selectedTime.minute);
      });
    }
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
        date = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
            time.hour, time.minute);
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
