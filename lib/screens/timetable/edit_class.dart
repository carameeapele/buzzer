import 'package:buzzer/main.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/screens/timetable/class_types.dart';
import 'package:buzzer/widgets/buttons.dart';
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
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(title: const Text('Add Class')),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
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
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: BuzzerColors.lightGrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
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
                      const SizedBox(
                        height: 5.0,
                      ),
                      TextFieldRow(
                        label: 'Room',
                        defaultValue: room,
                        width: 80.0,
                        onChannge: (value) {
                          room = value;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      const SizedBox(height: 5.0),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: BuzzerColors.lightGrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextButtonRow(
                        label: 'Reminder',
                        text: '1 hour before',
                        icon: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                ValueTextFieldWidget(
                  labelText: 'Professor Email',
                  defaultValue: professorEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    professorEmail = value;
                  },
                ),
                const SizedBox(height: 20.0),
                ValueTextFieldWidget(
                  labelText: 'Details',
                  defaultValue: details,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    details = value;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                _options(),
              ],
            ),
          ),
        ),
      ),
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

  Row _options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: OutlinedTextButtonWidget(
            text: 'Cancel',
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            },
            color: BuzzerColors.orange,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: FilledTextButtonWidget(
            text: 'Save',
            icon: false,
            onPressed: () {
              _editClass();

              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            },
            backgroundColor: BuzzerColors.orange,
            textColor: Colors.white,
          ),
        ),
      ],
    );
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
