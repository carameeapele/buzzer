import 'package:buzzer/main.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({Key? key}) : super(key: key);

  @override
  State<ProjectsList> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  @override
  Widget build(BuildContext context) {
    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    Widget defaultScreen = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.list_alt_rounded,
            size: 50.0,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 5.0),
          Text(
            'Click + to add an event',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.grey[300],
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );

    return ValueListenableBuilder<Box<Project>>(
      valueListenable: Hive.box<Project>('projects').listenable(),
      builder: (context, box, widget) {
        final projects = box.values.toList().cast<Project>();

        return projects.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                itemCount: projects.length,
                itemBuilder: (BuildContext context, int index) {
                  Project project = projects[index];

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
                        title: title(
                            project.title, project.category, project.date),
                        trailing: trailing(project.date),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 0.0,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        children: <Widget>[
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
                                  setState(() {});
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

  RichText title(
    String title,
    String tag,
    DateTime date,
  ) {
    return RichText(
      text: TextSpan(
        text: tag,
        style: TextStyle(
          color:
              date.isAfter(DateTime.now()) ? Colors.black : BuzzerColors.grey,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
          decoration:
              date.isAfter(DateTime.now()) ? null : TextDecoration.lineThrough,
          decorationThickness: 2.0,
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
      '${DateFormat('dd.MM', 'en_US').format(date)}  ',
      style: TextStyle(
        color: date.isAfter(DateTime.now()) ? Colors.black : BuzzerColors.grey,
        fontSize: 16.0,
      ),
    );
  }
}
