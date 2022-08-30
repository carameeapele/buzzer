import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/tasks/edit_task_screen.dart';
import 'package:buzzer/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    int index = -1;

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

        return Scaffold(
          appBar: AddAppBarWidget(
            title: 'Tasks',
            onPressed: () {
              Navigator.pushNamed(context, '/add_task');
            },
          ),
          drawer: const MenuDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

                          return Card(
                            elevation: 0.0,
                            color: BuzzerColors.lightGrey,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Theme(
                              data: data,
                              child: ExpansionTile(
                                title: title(task.title, task.category,
                                    task.date, task.complete),
                                subtitle: subtitle(task.complete, task.date),
                                trailing: Checkbox(
                                  value: task.complete,
                                  onChanged: (value) {
                                    _completeTask(task, value!);
                                  },
                                  fillColor: MaterialStateProperty.all(
                                      BuzzerColors.orange),
                                  checkColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.7),
                                    ),
                                  ),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTaskScreen(task: task),
                                            ),
                                          );
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
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
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

  RichText title(
    String title,
    String category,
    DateTime date,
    bool complete,
  ) {
    return RichText(
      text: TextSpan(
        text: (category.compareTo('None') == 0) ? '' : category,
        style: TextStyle(
          color: complete ? BuzzerColors.grey : Colors.black,
          fontSize: 17.0,
          decoration: complete ? TextDecoration.lineThrough : null,
          decorationThickness: 2.0,
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

  RichText subtitle(
    bool complete,
    DateTime date,
  ) {
    return RichText(
      text: TextSpan(
        text: '${DateFormat('dd MMM', 'en_US').format(date)}  ',
        style: TextStyle(
          color: complete ? BuzzerColors.grey : Colors.black,
          fontSize: 13.0,
        ),
        children: date.isAfter(DateTime.now())
            ? null
            : <TextSpan>[
                TextSpan(
                  text: 'OVERDUE',
                  style: TextStyle(
                    color: complete ? BuzzerColors.grey : BuzzerColors.orange,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
      ),
    );
  }
}
