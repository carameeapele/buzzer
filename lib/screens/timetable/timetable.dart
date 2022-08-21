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

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AddAppBarWidget(
        title: 'Timetable',
        onPressed: () {},
      ),
      drawer: const MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.black,
            labelStyle: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700),
            unselectedLabelColor: BuzzerColors.grey,
            indicatorColor: Colors.white,
            tabs: const <Widget>[
              Tab(text: 'Monday'),
              Tab(text: 'Tuesday'),
              Tab(text: 'Wednesday'),
              Tab(text: 'Thursday'),
              Tab(text: 'Friday'),
            ],
          ),
          SizedBox(
            height: 300,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
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
