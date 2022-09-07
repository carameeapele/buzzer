import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/screens/timetable/class_types.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class AddClass extends StatefulWidget {
  const AddClass({
    Key? key,
    required this.day,
    required this.week,
  }) : super(key: key);

  final String day;
  final int week;

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  late String title;
  late String day = widget.day;
  late String type = 'None';
  DateTime startTime = DateTime.now().add(const Duration(hours: 1));
  late DateTime endTime = startTime.add(const Duration(hours: 2));
  String room = '';
  String building = '';
  String professorEmail = '';
  String details = '';

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
                  labelText: 'Class Name',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChannge: (value) {
                    title = value.trim();
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
                  label: 'Start',
                  text: DateFormat.Hm().format(startTime),
                  icon: false,
                  onPressed: _selectStartTime,
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'End',
                  text: DateFormat.Hm().format(endTime),
                  icon: false,
                  onPressed: _selectEndTime,
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'Class Type',
                  text: type,
                  icon: true,
                  onPressed: () {
                    _getType(context);
                  },
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'Building',
                  text: building,
                  icon: true,
                  onPressed: () {},
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'Room',
                  text: room,
                  icon: true,
                  onPressed: () {},
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'Reminder',
                  text: 'None',
                  icon: true,
                  onPressed: () {},
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextFieldWidget(
                  labelText: 'Professor Email',
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    professorEmail = value;
                  },
                  validator: (value) {
                    if (value == '' ||
                        (value!.contains('@') && value.contains('.'))) {
                      return null;
                    } else {
                      return 'Invalid email address';
                    }
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
    if (title != '') {
      final dayClass = Course(
        id: _id(),
        title: title,
        day: day,
        type: type,
        startTime: DateTime(
          startTime.year,
          startTime.month,
          startTime.day,
          startTime.hour,
          startTime.minute,
        ),
        endTime: DateTime(
          endTime.year,
          endTime.month,
          endTime.day,
          endTime.hour,
          endTime.minute,
        ),
        room: room,
        professorEmail: professorEmail,
        details: details,
        week: 1,
      );

      final classBox = Hive.box<Course>('classes');
      classBox.add(dayClass);

      final categoryBox = Hive.box<Category>('categories');
      final categories = categoryBox.values.toList().cast<Category>();

      final index = categories.indexWhere(
          (category) => category.name.compareTo(dayClass.title) == 0);

      if (index == -1) {
        categoryBox.add(Category(name: title, uses: 1));
      } else {
        categories[index].uses++;
        categories[index].save();
      }
    }

    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  Future<void> _getType(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClassTypes(selectedType: type)),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        type = result;
      });
    }
  }

  Future _selectStartTime() async {
    DateTime now = DateTime.now();
    TimeOfDay initialTime = TimeOfDay.fromDateTime(startTime);

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
      if (selectedTime.hour < endTime.hour) {
        setState(() {
          startTime = DateTime(
            now.year,
            now.month,
            now.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      } else if (selectedTime.hour == endTime.hour) {
        if (selectedTime.minute < endTime.minute) {
          setState(() {
            startTime = DateTime(
              now.year,
              now.month,
              now.day,
              selectedTime.hour,
              selectedTime.minute,
            );
          });
        }
      } else {
        setState(() {
          endTime.add(const Duration(hours: 2));
        });
      }
    }

    if (selectedTime != null) {
      setState(() {
        startTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
  }

  Future _selectEndTime() async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(endTime);

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
      if (selectedTime.hour > startTime.hour) {
        setState(() {
          endTime = DateTime(
            startTime.year,
            startTime.month,
            startTime.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      } else if (selectedTime.hour == startTime.hour) {
        if (selectedTime.minute > startTime.minute) {
          setState(() {
            endTime = DateTime(
              startTime.year,
              startTime.month,
              startTime.day,
              selectedTime.hour,
              selectedTime.minute,
            );
          });
        }
      }
    }
  }
}
