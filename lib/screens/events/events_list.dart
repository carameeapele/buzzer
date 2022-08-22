import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

    return Container();
  }
}
