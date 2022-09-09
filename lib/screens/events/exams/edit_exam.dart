import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/screens/categories.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditExam extends StatefulWidget {
  const EditExam({
    Key? key,
    required this.exam,
  }) : super(key: key);

  final Exam exam;

  @override
  State<EditExam> createState() => _EditExamState();
}

class _EditExamState extends State<EditExam> {
  late String title = widget.exam.title;
  late DateTime date = widget.exam.date;
  late DateTime time = widget.exam.time;
  late String category = widget.exam.category;
  late String details = widget.exam.details;
  late String room = widget.exam.room;
  late String building = widget.exam.building;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomOptions(context, _editExam),
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
                  labelText: 'New Exam',
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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
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
                  text: '1 hour before',
                  icon: true,
                  onPressed: () {},
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

  void _editExam() {
    widget.exam.title = title;
    widget.exam.date = date;
    widget.exam.time = time;
    widget.exam.category = category;
    widget.exam.details = details;
    widget.exam.room = room;
    widget.exam.building = building;

    widget.exam.save();
    Navigator.of(context).pop();
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
        date = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
            time.hour, time.minute);
      });
    }
  }
}
