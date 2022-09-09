import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/events/projects/add_project_task.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectTasks extends StatefulWidget {
  const ProjectTasks({
    Key? key,
    required this.category,
    required this.date,
    required this.tasks,
  }) : super(key: key);

  final String category;
  final DateTime date;
  final List<Task> tasks;

  @override
  State<ProjectTasks> createState() => _ProjectTasksState();
}

class _ProjectTasksState extends State<ProjectTasks> {
  late List<Task> tasks = widget.tasks;

  @override
  Widget build(BuildContext context) {
    tasks.sort((a, b) => a.date.compareTo(b.date));

    return Scaffold(
      bottomNavigationBar: bottomOptions(context, _onSave),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            tasks.isEmpty
                ? customCard(
                    const Center(
                      heightFactor: 3.0,
                      child: Text('No Tasks'),
                    ),
                    false,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];

                      return customCard(
                        ListTile(
                          title: taskTitle(
                            task.title,
                            task.category,
                            task.date,
                          ),
                          trailing: Text(
                            DateFormat('dd MMM').format(task.date),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: task.details.isNotEmpty
                              ? Text(task.details)
                              : null,
                        ),
                        false,
                      );
                    },
                  ),
            OutlinedTextButtonWidget(
              text: '+ Add Task',
              onPressed: () {
                _addTask(context);
              },
              color: BuzzerColors.orange,
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    Navigator.of(context).pop<List<Task>>(tasks);
  }

  Future<void> _addTask(BuildContext context) async {
    final Task? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddProjectTask(
          category: widget.category,
          date: widget.date,
        ),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        tasks.add(result);
      });
    }
  }
}
