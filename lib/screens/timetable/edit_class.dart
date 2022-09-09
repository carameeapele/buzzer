import 'package:buzzer/main.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/screens/timetable/class_types.dart';
import 'package:buzzer/screens/timetable/week_picker.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
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
  late int optionIndex = widget.classs.week;
  late String building = widget.classs.building;

  List<String> options = ['Every Week', 'Odd Week', 'Even Week'];

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
                    title = value.trim();
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
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                TextButtonRow(
                  label: 'Week',
                  text: options[optionIndex],
                  icon: false,
                  onPressed: () {
                    _weekPicker();
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
                  icon: false,
                  onPressed: () {
                    _getType();
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
                  borderRadius: const BorderRadius.all(Radius.zero),
                ),
                ValueTextFieldWidget(
                  labelText: 'Professor Email',
                  defaultValue: professorEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    professorEmail = value.trim();
                  },
                  validator: (value) {
                    if (value!.contains('@') && value.contains('.')) {
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
      bottomNavigationBar: bottomOptions(context, _editClass),
    );
  }

  Future<void> _getType() async {
    final result = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      builder: (BuildContext context) {
        return ClassTypes(selectedType: type);
      },
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
    widget.classs.week = optionIndex;
    widget.classs.building = building;

    widget.classs.save();
    Navigator.of(context).pop();
  }

  Future<void> _weekPicker() async {
    final result = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
      context: context,
      builder: (BuildContext context) {
        return WeekPicker(optionIndex: optionIndex);
      },
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        optionIndex = result;
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
