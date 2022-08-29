import 'package:buzzer/main.dart';
import 'package:buzzer/models/class_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

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
          fontFamily: 'Roboto',
          color: Colors.grey[300],
          fontSize: 16.0,
        ),
      ),
    );

    return ValueListenableBuilder<Box<Class>>(
      valueListenable: Hive.box<Class>('classes').listenable(),
      builder: (context, box, widget) {
        final classes = box.values.toList().cast<Class>();
        classes.removeWhere((element) => element.day.compareTo(day) != 0);

        return classes.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                itemCount: classes.length,
                itemBuilder: (BuildContext context, int index) {
                  Class dayClass = classes[index];

                  return Card(
                    elevation: 0.0,
                    color: BuzzerColors.lightGrey,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    child: Theme(
                      data: data,
                      child: ExpansionTile(
                        tilePadding:
                            const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                        title: title(dayClass.title, dayClass.type),
                        trailing: trailing(dayClass.startTime),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 0.0,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        children: <Widget>[
                          dayClass.details.isNotEmpty
                              ? Text(dayClass.details)
                              : const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  _deleteClass(dayClass);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  void _deleteClass(Class dayClass) {
    dayClass.delete();
  }

  RichText title(
    String title,
    String tag,
  ) {
    return RichText(
      text: TextSpan(
        text: tag,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' $title',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Text trailing(DateTime date) {
    return Text(
      '${DateFormat('dd MMM', 'en_US').format(date)}  ',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    );
  }
}
