import 'package:buzzer/main.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/screens/tasks/categories.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editProject() {
    widget.project.title = title;
    widget.project.date = date;
    widget.project.time = time;
    widget.project.category = category;

    widget.project.save();
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
        date = selectedDate;
      });
    }
  }
}
