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
  String professorEmail = '';
  String details = '';

  String _id() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Class'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
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
                TextFieldWidget(
                  labelText: 'Class Name',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChannge: (value) {
                    title = value;
                  },
                ),
                const Divider(),
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
                  defaultValue: '',
                  width: 80.0,
                  onChannge: (value) {
                    room = value;
                  },
                ),
                const SizedBox(height: 10.0),
                const Divider(),
                Column(
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
                const SizedBox(height: 20.0),
                TextFieldWidget(
                  labelText: 'Professor Email',
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    professorEmail = value;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFieldWidget(
                  labelText: 'Details',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {
                    details = value;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                options(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row options() {
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
              if (title.isNotEmpty) {
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
            },
            backgroundColor: BuzzerColors.orange,
            textColor: Colors.white,
          ),
        ),
      ],
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

        endTime = startTime.add(const Duration(hours: 2));
      });
    }
  }

  Future _selectEndTime() async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(endTime);

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      hourLabelText: initialTime.hour.toString(),
      minuteLabelText: initialTime.minute.toString(),
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
      } else {}
    }
  }
}
