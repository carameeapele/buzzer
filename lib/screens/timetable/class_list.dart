import 'package:buzzer/main.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/screens/timetable/edit_class.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClassList extends StatefulWidget {
  const ClassList({
    Key? key,
    required this.day,
  }) : super(key: key);

  final String day;

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) {
    final String day = widget.day;
    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    Widget defaultScreen = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Text(
        'Click + to add a class',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 16.0,
        ),
      ),
    );

    return ValueListenableBuilder<Box<Course>>(
      valueListenable: Hive.box<Course>('classes').listenable(),
      builder: (context, box, widget) {
        final classes = box.values.toList().cast<Course>();
        classes.removeWhere((element) => element.day.compareTo(day) != 0);
        if (classes.isNotEmpty) {
          classes.sort((a, b) => a.startTime.compareTo(b.startTime));
        }

        return classes.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                itemCount: classes.length,
                itemBuilder: (BuildContext context, int index) {
                  Course dayClass = classes[index];

                  return customCard(
                    Theme(
                      data: data,
                      child: ExpansionTile(
                        tilePadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        title: classTitle(dayClass.title, dayClass.type),
                        trailing: Text(
                          DateFormat('Hm', 'en_US').format(dayClass.startTime),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 0.0,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        children: <Widget>[
                          if (dayClass.room.isNotEmpty)
                            classRow(
                              'Room',
                              Text(
                                dayClass.room,
                                style: TextStyle(
                                  color: BuzzerColors.grey,
                                ),
                              ),
                            ),
                          if (dayClass.professorEmail.isNotEmpty)
                            classRow(
                              dayClass.professorEmail,
                              Row(
                                children: [
                                  IconButton(
                                    splashRadius: 20.0,
                                    iconSize: 18.0,
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                            text: dayClass.professorEmail),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Email copied to clipboard'),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: BuzzerColors.grey,
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: 20.0,
                                    iconSize: 18.0,
                                    onPressed: () => openEmail(
                                        professor: dayClass.professorEmail),
                                    icon: Icon(
                                      Icons.mail_outline,
                                      color: BuzzerColors.grey,
                                    ),
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                ],
                              ),
                            ),
                          if (dayClass.details.isNotEmpty)
                            Text(
                              dayClass.details,
                              textAlign: TextAlign.end,
                              style: TextStyle(color: BuzzerColors.grey),
                            ),
                          tileOptions(
                            context,
                            EditClass(classs: dayClass),
                            () {
                              dayClass.delete();
                            },
                          ),
                        ],
                      ),
                    ),
                    false,
                  );
                },
              );
      },
    );
  }

  Future openEmail({required String professor}) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: professor,
    );
  }
}
