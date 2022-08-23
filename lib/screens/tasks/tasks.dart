import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/services/providers.dart';
import 'package:buzzer/widgets/add_app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    ref.read(tasksFetchProvider);
  }

  void deleteTask(Task task) {
    ref.read(tasksProvider.notifier).state.remove(task);
    DatabaseService(uid: _auth.toString()).deleteTask(task.id);
  }

  Future<void> addTask(Task task) async {
    ref.read(tasksProvider.notifier).state.add(task);
    DatabaseService(uid: _auth.toString()).addTasks(task);
  }

  void editTask(Task task) {}

  @override
  Widget build(BuildContext context) {
    AddAppBarWidget appBar = AddAppBarWidget(
        title: 'Tasks',
        onPressed: () {
          Navigator.of(context).pushNamed('/add_task');
        });

    Widget defaultScreen = Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      drawer: const MenuDrawer(),
      body: Container(
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
        ),
      ),
    );

    final tasksList = ref.watch(tasksFetchProvider);

    return Container(
      child: tasksList.when(
        data: (List<Task> tasks) {
          return tasks.isEmpty
              ? defaultScreen
              : Scaffold(
                  backgroundColor: Colors.white,
                  extendBodyBehindAppBar: false,
                  appBar: appBar,
                  drawer: const MenuDrawer(),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 25.0,
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: tasks.length,
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
                              child: ExpansionTile(
                                title: title(task.title, task.category,
                                    task.date, task.complete),
                                subtitle: subtitle(task.complete, task.date),
                                trailing: trailing(task.complete, task.id),
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
                                        onPressed: () {},
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
                                          setState(() {
                                            deleteTask(task);
                                          });
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
                            );
                          },
                        ),
                      ],
                    )),
                  ),
                );
        },
        error: (Object error, StackTrace? stackTrace) {
          return Container();
        },
        loading: () {
          return const Loading();
        },
      ),
    );
  }

  RichText title(
    String title,
    String category,
    Timestamp date,
    bool complete,
  ) {
    return RichText(
      text: TextSpan(
        text: category,
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
    Timestamp date,
  ) {
    return RichText(
      text: TextSpan(
        text: '${DateFormat('dd MMM', 'en_US').format(date.toDate())}  ',
        style: TextStyle(
          color: complete ? BuzzerColors.grey : Colors.black,
          fontSize: 13.0,
        ),
        children: date.toDate().isAfter(DateTime.now())
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

  Checkbox trailing(
    bool complete,
    String id,
  ) {
    return Checkbox(
      value: complete,
      onChanged: (value) async {
        setState(() {
          complete = !complete;
        });

        await DatabaseService(uid: _auth.toString()).completeTask(id, complete);
      },
      fillColor: MaterialStateProperty.all(BuzzerColors.orange),
      checkColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.7),
        ),
      ),
    );
  }

  Widget defaultScreen = Scaffold();
}
