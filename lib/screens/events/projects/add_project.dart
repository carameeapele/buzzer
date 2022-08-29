import 'package:buzzer/main.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/screens/categories.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
import 'package:buzzer/widgets/form_field.dart';
import 'package:buzzer/widgets/outlined_text_button_widget.dart';
import 'package:buzzer/widgets/text_row.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  late String title;
  DateTime date = DateTime.now();
  late DateTime time = date.add(const Duration(hours: 1));

  String category = 'None';

  String _id() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  Future selectTime() async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(time);

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

  Future<void> _getCategory(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Categories()),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        category = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: const AppBarWidget(title: 'Add Project'),
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
                  labelText: 'Project Name',
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
                        onPressed: () {
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
                            final project = Project(
                                id: _id(),
                                title: title,
                                category: category,
                                date: date,
                                time: time,
                                complete: false);

                            final box = Hive.box<Project>('projects');
                            box.add(project);
                          }

                          Navigator.of(context).pop();
                        },
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