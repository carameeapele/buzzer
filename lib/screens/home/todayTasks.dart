import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/services/providers.dart';
import 'package:buzzer/widgets/filled_text_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayTasks extends ConsumerStatefulWidget {
  const TodayTasks({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodayTasksState();
}

class _TodayTasksState extends ConsumerState<TodayTasks> {
  @override
  void initState() {
    super.initState();
    ref.read(tasksFetchProvider);
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksFetchProvider);

    return Container(
      child: tasks.when(
        data: (List<Task> tasks) {
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
                            title: RichText(
                              text: TextSpan(
                                text: task.category,
                                style: TextStyle(
                                  color: task.complete
                                      ? BuzzerColors.grey
                                      : Colors.black,
                                  fontSize: 17.0,
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
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Text(
                              DateFormat('dd MMM', 'en_US')
                                  .format(task.dueDate.toDate()),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: task.dueDate
                                        .toDate()
                                        .isAfter(DateTime.now())
                                    ? Colors.black
                                    : BuzzerColors.orange,
                                fontWeight: task.dueDate
                                        .toDate()
                                        .isAfter(DateTime.now())
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
        },
        error: (Object error, StackTrace? stackTrace) {
          return Column();
        },
        loading: () {
          return Container();
        },
      ),
    );
  }
}
