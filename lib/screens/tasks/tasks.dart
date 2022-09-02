import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/tasks/edit_task_screen.dart';
import 'package:buzzer/style/custom_widgets.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    Widget defaultScreen = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.emoji_food_beverage_rounded,
          size: 50.0,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 5.0),
        Text(
          'Click + to add a task',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.grey[300],
            fontSize: 16.0,
          ),
        ),
      ],
    );

    return ValueListenableBuilder<Box<Task>>(
      valueListenable: Hive.box<Task>('tasks').listenable(),
      builder: (context, box, widget) {
        final tasks = box.values.toList().cast<Task>();
        tasks.sort((a, b) => a.date.compareTo(b.date));

        return Scaffold(
          appBar: AppBar(title: const Text('Tasks')),
          endDrawer: const MenuDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                tasks.isEmpty
                    ? defaultScreen
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          final task = tasks[index];

                          return Opacity(
                            opacity: task.complete ? 0.4 : 1.0,
                            child: Card(
                              child: Theme(
                                data: data,
                                child: ExpansionTile(
                                  title: taskTitle(task.title, task.category,
                                      task.date, task.complete),
                                  subtitle: taskSubtitle(
                                      task.complete, task.date, task.time),
                                  trailing: Checkbox(
                                    value: task.complete,
                                    onChanged: (value) {
                                      _completeTask(task, value!);
                                    },
                                  ),
                                  childrenPadding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  expandedAlignment: Alignment.centerLeft,
                                  children: <Widget>[
                                    task.details.isNotEmpty
                                        ? Text(task.details)
                                        : const SizedBox(),
                                    options(task),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
          floatingActionButton: IconButton(
            icon: Icon(
              Icons.add_box,
              color: BuzzerColors.orange,
            ),
            iconSize: 35.0,
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Navigator.of(context).pushNamed('/add_task');
            },
          ),
        );
      },
    );
  }

  void _completeTask(Task task, bool value) {
    task.complete = value;
    task.save();
  }

  void _deleteTask(Task task) {
    task.delete();
  }

  Row options(Task task) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: task),
              ),
            );
          },
          child: const Text(
            'Edit',
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        TextButton(
          onPressed: () {
            _deleteTask(task);
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
