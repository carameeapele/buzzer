import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:buzzer/widgets/menu_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>?>.value(
      value: DatabaseService(uid: '').events,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBarWidget(
          title: 'Calendar',
        ),
        drawer: const MenuDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[],
          ),
        ),
      ),
    );
  }
}

void addEvent(Event newEvent) {}
