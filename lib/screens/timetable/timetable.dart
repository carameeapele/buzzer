import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/add_app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';

import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({Key? key}) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen>
    with TickerProviderStateMixin {
  bool loading = false;

  AddAppBarWidget appBar = AddAppBarWidget(
    title: 'Timetable',
    onPressed: () {},
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(
      length: 5,
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
        Tab(text: 'Monday'),
        Tab(text: 'Tuesday'),
        Tab(text: 'Wednesday'),
        Tab(text: 'Thursday'),
        Tab(text: 'Friday'),
      ],
    );

    final double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        68.0;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: appBar,
      drawer: const MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          tabBar,
          SizedBox(
            height: height,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  Text('monday'),
                  Text('tuesday'),
                  Text('wednesday'),
                  Text('thursday'),
                  Text('friday'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
