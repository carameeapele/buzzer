import 'package:buzzer/main.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/events/projects/edit_project.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
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
            'Click + to add a project',
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
        projects.sort((a, b) => a.date.compareTo(b.date));

        return projects.isEmpty
            ? defaultScreen
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (BuildContext context, int index) {
                  final project = projects[index];
                  final List<Task> tasks = [];
                  final List<Task> completeTasks = [];

                  DateTime now = DateTime.now();
                  bool _isToday = (project.date.day == now.day &&
                      project.date.month == now.month &&
                      project.date.year == now.year);

                  return customCard(
                    Theme(
                      data: data,
                      child: ExpansionTile(
                        tilePadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        title: classTitle(project.title, project.category),
                        subtitle: LinearProgressIndicator(
                          color: BuzzerColors.orange,
                          value: 0.5,
                        ),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 0.0,
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              final task = tasks[index];

                              return Text(task.title);
                              // return ListTile(
                              //   dense: true,
                              //   title: Text(task.title),
                              //   trailing: Checkbox(
                              //     value: task.complete,
                              //     onChanged: (value) {
                              //       task.complete = value!;
                              //       task.save();
                              //     },
                              //   ),
                              // );
                            },
                          ),
                          options(project),
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

  final projectTiles = <ListTile>[];

  RichText title(
    String title,
    String category,
    DateTime date,
    DateTime time,
  ) {
    DateTime now = DateTime.now();
    bool _isBefore = (date.isBefore(now));

    return RichText(
      text: TextSpan(
        text: (category.compareTo('None') == 0) ? '' : category,
        style: TextStyle(
          color: (_isBefore && time.isBefore(now))
              ? BuzzerColors.grey
              : Colors.black,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
          decoration: (_isBefore && time.isBefore(now))
              ? TextDecoration.lineThrough
              : null,
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

  Text trailing(DateTime date, DateTime time) {
    DateTime now = DateTime.now();
    bool _isToday = (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year);

    return Text(
      _isToday
          ? DateFormat('Hm', 'en_US').format(time)
          : DateFormat('dd MMM', 'en_US').format(date),
      style: TextStyle(
        color: ((date.isBefore(now) && time.isBefore(now)))
            ? BuzzerColors.grey
            : Colors.black,
        fontSize: 16.0,
      ),
    );
  }

  void _deleteProject(Project project) {
    project.delete();
  }

  Row options(Project project) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProject(
                  project: project,
                ),
              ),
            );
          },
          child: const Text('Edit'),
        ),
        const SizedBox(
          width: 5.0,
        ),
        TextButton(
          onPressed: () {
            _deleteProject(project);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
