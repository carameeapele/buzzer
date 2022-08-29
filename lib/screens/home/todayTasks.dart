import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
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

          return tasks.isEmpty
              ? FilledTextButtonWidget(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/add_task');
                  },
                  text: 'Add',
                  icon: true,
                  backgroundColor: BuzzerColors.lightGrey,
                  textColor: Colors.black,
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
                        return Card(
                          elevation: 0.0,
                          color: BuzzerColors.lightGrey,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: ListTile(
                            dense: true,
                            title: RichText(
                              text: TextSpan(
                                text: task.category.compareTo('None') == 0
                                    ? ''
                                    : task.category,
                                style: TextStyle(
                                  color: task.complete
                                      ? BuzzerColors.grey
                                      : Colors.black,
                                  fontSize: 16.0,
                                  decoration: task.complete
                                      ? TextDecoration.lineThrough
                                      : null,
                                  decorationThickness: 2.0,
                                  fontStyle: FontStyle.italic,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' ${task.title}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Text(
                              DateFormat('dd MMM', 'en_US').format(task.date),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: task.date.isAfter(DateTime.now())
                                    ? Colors.black
                                    : BuzzerColors.orange,
                                fontWeight: task.date.isAfter(DateTime.now())
                                    ? null
                                    : FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).popAndPushNamed('/tasks');
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
        });
  }
}
