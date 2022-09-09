import 'package:buzzer/main.dart';
import 'package:buzzer/models/project_model.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/events/projects/edit_project.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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

        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: projects.length,
          itemBuilder: (BuildContext context, int index) {
            final project = projects[index];
            final List<Task> tasks = project.tasks.toList().cast<Task>();

            late int completeTasks =
                tasks.where((task) => task.complete).length;

            late double progress = (completeTasks == 0)
                ? 0.0
                : (completeTasks * (1 / tasks.length));

            return customCard(
              Theme(
                data: data,
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: classTitle(project.title, project.category),
                  subtitle: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    color: BuzzerColors.orange,
                    value: progress,
                  ),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 0.0,
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: <Widget>[
                    tasks.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              final task = tasks[index];

                              return ListTile(
                                dense: true,
                                title: Text(
                                  task.title,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                trailing: Checkbox(
                                  value: task.complete,
                                  onChanged: (value) {
                                    setState(() {
                                      task.complete = value!;
                                      task.save();

                                      if (value) {
                                        progress =
                                            progress + (1 / tasks.length);
                                      } else {
                                        progress =
                                            progress - (1 / tasks.length);
                                      }
                                    });
                                  },
                                ),
                              );
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

  void _deleteProject(Project project) {
    project.tasks.deleteAllFromHive();
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
