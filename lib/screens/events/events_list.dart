import 'package:buzzer/models/event_model.dart';
import 'package:buzzer/screens/events/event_tile.dart';
import 'package:buzzer/widgets/app_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsList extends StatefulWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> events =
        FirebaseFirestore.instance.collection('events').snapshots();

    // return ListView.builder(
    //   itemCount: events.length,
    //   itemBuilder: (context, index) {
    //     return EventTile(event: events[index]);
    //   },
    // );

    return Container();
  }
}
