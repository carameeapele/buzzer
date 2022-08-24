import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/outlined_text_button_widget.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late String title;
  late DateTime date = DateTime.now();
  late TimeOfDay time =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1)));
  late String category;
  late String details;

  Future selectTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: time,
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
        time = selectedTime;
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
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: BuzzerColors.orange,
                onPrimary: Colors.white,
                onSecondary: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: BuzzerColors.orange,
                ),
              ),
            ),
            child: child!,
          );
        });

    if (selectedDate != null) {
      setState(() {
        date = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: const AppBarWidget(title: 'Add Task'),
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
                  labetText: 'Task Name',
                  keyboardType: TextInputType.text,
                  obscureText: false,
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
                      TextRow(
                        label: 'Date',
                        text: DateFormat(
                          'd MMMM',
                        ).format(date),
                        icon: false,
                        onPressed: selectDate,
                      ),
                      TextRow(
                        label: 'Time',
                        text: DateFormat.Hm().format(DateTime(date.year,
                            date.month, date.day, time.hour, time.minute)),
                        icon: false,
                        onPressed: selectTime,
                      ),
                      TextRow(
                        label: 'Category',
                        text: 'None',
                        icon: true,
                        onPressed: () {},
                      ),
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
                      TextRow(
                        label: 'Reminder',
                        text: '1 hour before',
                        icon: true,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFieldWidget(
                  labetText: 'Details',
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  textCapitalization: TextCapitalization.none,
                  onChannge: (value) {},
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: OutlinedTextButtonWidget(
                        text: 'Cancel',
                        function: () {
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
                        onPressed: () {},
                        backgroundColor: BuzzerColors.orange,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
