import 'package:buzzer/main.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/screens/timetable/class_types.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class EditClass extends StatefulWidget {
  const EditClass({
    Key? key,
    required this.classs,
  }) : super(key: key);

  final Course classs;

  @override
  State<EditClass> createState() => _EditClassState();
}

class _EditClassState extends State<EditClass> {
  late String title = widget.classs.title;
  late String day = widget.classs.day;
  late String type = widget.classs.type;
  late DateTime startTime = widget.classs.startTime;
  late DateTime endTime = widget.classs.endTime;
  late String room = widget.classs.room;
  late String professorEmail = widget.classs.professorEmail;
  late String details = widget.classs.details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  labelText: 'Class Name',
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
                        label: 'Start',
                        text: DateFormat.Hm().format(startTime),
                        icon: false,
                        onPressed: _selectStartTime,
                      ),
                      TextButtonRow(
                        label: 'End',
                        text: DateFormat.Hm().format(endTime),
                        icon: false,
                        onPressed: _selectEndTime,
                      ),
                      TextButtonRow(
                        label: 'Class Type',
                        text: type,
                        icon: true,
                        onPressed: () {
                          _getType(context);
                        },
                      ),
                      TextFieldRow(
                        label: 'Room',
                        defaultValue: room,
                        width: 80.0,
                        onChannge: (value) {
                          room = value;
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
                ValueTextFieldWidget(
                  labelText: 'Professor Email',
                  defaultValue: professorEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    professorEmail = value;
                  },
                  validator: (value) {
                    if (value!.contains('@') && value.contains('.')) {
                      return null;
                    } else {
                      return 'Invalid email address';
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomOptions(context, _editClass),
    );
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

  void _editClass() {
    widget.classs.title = title;
    widget.classs.day = day;
    widget.classs.startTime = startTime;
    widget.classs.endTime = endTime;
    widget.classs.type = type;
    widget.classs.room = room;
    widget.classs.professorEmail = professorEmail;
    widget.classs.details = details;

    final categoryBox = Hive.box<Category>('categories');
    categoryBox.add(Category(name: title, uses: 1));

    widget.classs.save();
    Navigator.of(context).pop();
  }

  Future _selectStartTime() async {
    DateTime now = DateTime.now();
    TimeOfDay initialTime = TimeOfDay.fromDateTime(startTime);

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BuzzerColors.orange,
              onPrimary: Colors.white,
              onSecondary: Colors.black,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );

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
    DateTime now = DateTime.now();
    TimeOfDay initialTime = TimeOfDay.fromDateTime(endTime);

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BuzzerColors.orange,
              onPrimary: Colors.white,
              onSecondary: Colors.black,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        endTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
  }
}
