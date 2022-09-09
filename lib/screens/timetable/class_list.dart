import 'package:buzzer/main.dart';
import 'package:buzzer/models/category_model.dart';
import 'package:buzzer/models/course_model.dart';
import 'package:buzzer/screens/timetable/edit_class.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late int weekNumber = preferences.get('weekNumber', defaultValue: 1);

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

        if (weekNumber % 2 == 0) {
          classes.removeWhere((element) => element.week == 1);
        } else {
          classes.removeWhere((element) => element.week == 2);
        }

        if (classes.isNotEmpty) {
          classes.sort((a, b) => a.startTime.compareTo(b.startTime));
        }

        return classes.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: classes.length,
                itemBuilder: (BuildContext context, int index) {
                  Course dayClass = classes[index];
                  bool _isNow =
                      (dayClass.startTime.hour < DateTime.now().hour &&
                          dayClass.endTime.hour > DateTime.now().hour);

                  return customCard(
                    Theme(
                      data: data,
                      child: ExpansionTile(
                        tilePadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        title: classTitle(dayClass.title, dayClass.type),
                        trailing: _isNow
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: BuzzerColors.orange,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0))),
                                child: const Text(
                                  'Now',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                DateFormat('Hm', 'en_US')
                                    .format(dayClass.startTime),
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
                          if (dayClass.building.isNotEmpty)
                            classRow(
                              'Building',
                              Text(
                                dayClass.building,
                                style: TextStyle(
                                  color: BuzzerColors.grey,
                                ),
                              ),
                            ),
                          if (dayClass.building.isNotEmpty)
                            const SizedBox(height: 10.0),
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
                              _deleteClass(dayClass);
                            },
                          ),
                        ],
                      ),
                    ),
                    _isNow,
                  );
                },
              );
      },
    );
  }

  void _deleteClass(Course course) {
    course.delete();

    final categoryBox = Hive.box<Category>('categories');
    final categories = categoryBox.values.toList().cast<Category>();

    final index = categories
        .indexWhere((category) => category.name.compareTo(course.title) == 0);

    if (index != -1) {
      categories[index].uses--;
      categories[index].save();

      if (categories[index].uses < 1) {
        categories[index].delete();
      }
    }
  }

  Future openEmail({required String professor}) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: professor,
    );

    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not acces email'),
        ),
      );
    }
  }
}
