import 'package:buzzer/main.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:buzzer/screens/events/events_list.dart';
import 'package:buzzer/screens/events/projects_list.dart';
import 'package:buzzer/screens/loading.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/services/providers.dart';
import 'package:buzzer/widgets/add_app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen>
    with TickerProviderStateMixin {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    ref.read(examsFetchProvider);
  }

  void addExam(Exam exam) {
    ref.read(examsProvider.notifier).state.add(exam);
    DatabaseService(uid: _auth.toString()).addExam(exam);
  }

  void deleteExam(Exam exam) {
    ref.read(examsProvider.notifier).state.remove(exam);
    DatabaseService(uid: _auth.toString()).deleteExam(exam.id);
  }

  void editExam(Exam exam) {}

  @override
  Widget build(BuildContext context) {
    AddAppBarWidget appBar = AddAppBarWidget(
      title: 'Events',
      onPressed: () {},
    );

    TabController _tabController = TabController(
      length: 2,
      vsync: this,
    );

    TabBar tabBar = TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelColor: BuzzerColors.grey,
      indicatorColor: Colors.white,
      tabs: const <Widget>[
        Tab(text: 'Exams'),
        Tab(text: 'Projects'),
      ],
    );

    final double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        68.0;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: appBar,
      drawer: const MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          tabBar,
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: height,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TabBarView(
                controller: _tabController,
                children: const [
                  EventsList(),
                  ProjectsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
