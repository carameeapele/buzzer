import 'package:buzzer/main.dart';
import 'package:buzzer/models/exam_model.dart';
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

    final data = Theme.of(context).copyWith(dividerColor: Colors.transparent);

    final double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        68.0;

    final examsList = ref.watch(examsFetchProvider);

    return Scaffold(
      body: examsList.when(
        data: (List<Exam> exams) {
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
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: exams.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (exams.isEmpty) {
                              return Container();
                            }

                            Exam exam = exams[index];
                            return Card(
                              elevation: 0.0,
                              color: BuzzerColors.lightGrey,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7.0),
                                ),
                              ),
                              child: Theme(
                                data: data,
                                child: ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  title: title(exam.title, exam.tag, exam.date),
                                  trailing: trailing(exam.date),
                                  childrenPadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 0.0,
                                  ),
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  expandedAlignment: Alignment.centerLeft,
                                  children: <Widget>[
                                    exam.notes.isNotEmpty
                                        ? Text(exam.notes)
                                        : const SizedBox(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              editExam(exam);
                                            });
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
                                            setState(() {
                                              deleteExam(exam);
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
                              ),
                            );
                          },
                        ),
                        const Text('projects'),
                      ],
                    ),
                  ),
                ),
              ],
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
    String tag,
    Timestamp date,
  ) {
    return RichText(
      text: TextSpan(
        text: tag,
        style: TextStyle(
          color: date.toDate().isAfter(DateTime.now())
              ? Colors.black
              : BuzzerColors.grey,
          fontSize: 17.0,
          fontStyle: FontStyle.italic,
          decoration: date.toDate().isAfter(DateTime.now())
              ? null
              : TextDecoration.lineThrough,
          decorationThickness: 2.0,
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

  Text trailing(Timestamp date) {
    return Text(
      '${DateFormat('dd.MM', 'en_US').format(date.toDate())}  ',
      style: TextStyle(
        color: date.toDate().isAfter(DateTime.now())
            ? Colors.black
            : BuzzerColors.grey,
        fontSize: 16.0,
      ),
    );
  }
}
