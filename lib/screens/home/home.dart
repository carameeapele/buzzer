import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:buzzer/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<TaskPointer>? getTodayTasks = generateTasks(3);
  final List<TaskPointer> tomorrowTasks = generateTasks(1);
  final List<TaskPointer> upcomingTasks = generateTasks(2);

  // final List<PanelItem> _panelItems = [
  //   PanelItem('Today', todayTasks, false),
  //   PanelItem('Tomorrow', false),
  //   PanelItem('Upcoming', false)
  // ];

  final now = DateTime.now();
  final AuthService _auth = AuthService();
  bool loading = false;

  void getTaskList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBarWidget(
        title: 'Today',
      ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                DateFormat('EEEEE', 'en_US').format(now),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                DateFormat('d MMMM', 'en_US').format(now),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Tasks',
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () async {
                  dynamic tasks =
                      await DatabaseService(uid: _auth.toString()).getTasks();

                  print(tasks.toString());
                },
                child: Text('Get Tasks'),
              ),
              //const TasksList(),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Schedule',
                style: subtitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<TaskPointer> generateTasks(int numberOfTasks) {
  return List<TaskPointer>.generate(numberOfTasks, (index) {
    return TaskPointer('Task Title', DateTime.now());
  });
}

class TaskPointer {
  String title;
  DateTime dueTime;

  TaskPointer(this.title, this.dueTime);
}

class PanelItem {
  String title;
  final List<TaskPointer> taskList;
  bool isExpanded;

  PanelItem(this.title, this.taskList, this.isExpanded);
}

// child: ExpansionPanelList(
//                   elevation: 0.0,
//                   expandedHeaderPadding: const EdgeInsets.all(5.0),
//                   animationDuration: const Duration(seconds: 1),
//                   expansionCallback: (int index, bool isExpanded) {
//                     setState(() {
//                       _panelItems[index].isExpanded = !isExpanded;
//                     });
//                   },
//                   children: _panelItems.map<ExpansionPanel>((PanelItem item) {
//                     return ExpansionPanel(
//                       canTapOnHeader: true,
//                       backgroundColor: item.isExpanded
//                           ? BuzzerColors.orange
//                           : BuzzerColors.lightGrey,
//                       headerBuilder: (BuildContext context, bool isExpanded) {
//                         return ListTile(
//                           textColor: isExpanded ? Colors.white : Colors.black,
//                           title: Text(
//                             item.title,
//                             style: const TextStyle(
//                               fontFamily: 'Roboto',
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(7.0),
//                             ),
//                           ),
//                           trailing: Text(
//                             todayTasks.length.toString(),
//                             style: const TextStyle(
//                               fontFamily: 'Roboto',
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         );
//                       },
//                       body: ListView.builder(
//                         itemCount: todayTasks.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return ListTile(
//                             textColor:
//                                 item.isExpanded ? Colors.white : Colors.black,
//                             title: Text(todayTasks[index].title),
//                             subtitle:
//                                 Text(todayTasks[index].dueTime.hour.toString()),
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(7.0),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       isExpanded: item.isExpanded,
//                     );
//                   }).toList(),
//                 ),