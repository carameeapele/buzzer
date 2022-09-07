import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/events/projects/add_project_task.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class ProjectTasks extends StatefulWidget {
  const ProjectTasks({
    Key? key,
    required this.category,
    required this.tasks,
  }) : super(key: key);

  final String category;
  final List<Task> tasks;

  @override
  State<ProjectTasks> createState() => _ProjectTasksState();
}

class _ProjectTasksState extends State<ProjectTasks> {
  final tasksBox = Hive.box<Task>('tasks');
  List<Task> tasks = <Task>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomOptions(context, _onSave),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            tasks.isEmpty
                ? const Center(
                    child: Text('No Tasks'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];

                      DateTime now = DateTime.now();
                      bool _isToday = (task.date.day == now.day &&
                          task.date.month == now.month &&
                          task.date.year == now.year);

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
                          subtitle: Text(task.details),
                        ),
                        _isToday,
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
        builder: (context) => AddProjectTask(category: widget.category),
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
