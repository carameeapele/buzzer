import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({Key? key}) : super(key: key);

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Task>>(
      valueListenable: Hive.box<Task>('tasks').listenable(),
      builder: (context, box, widget) {
        final tasks = box.values.toList().cast<Task>();
        tasks.removeWhere((task) => task.complete == true);
        tasks.sort((a, b) => a.date.compareTo(b.date));

        return tasks.isEmpty
            ? Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'No Tasks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15.0,
                      color: BuzzerColors.grey,
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length > 3 ? 3 : tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      Task task = tasks[index];
                      DateTime now = DateTime.now();
                      bool _isToday = (task.date.day == now.day &&
                          task.date.month == now.month &&
                          task.date.year == now.year);

                      return customCard(
                        ListTile(
                          dense: true,
                          title: taskTitle(task.title, task.category, task.date,
                              task.complete),
                          trailing: Text(
                            _isToday
                                ? DateFormat('Hm').format(task.time)
                                : DateFormat('dd MMM', 'en_US')
                                    .format(task.date),
                          ),
                          onTap: () {
                            Navigator.of(context).popAndPushNamed('/tasks');
                          },
                        ),
                        _isToday,
                      );
                    },
                  ),
                ],
              );
      },
    );
  }
}
