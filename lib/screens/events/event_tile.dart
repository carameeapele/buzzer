import 'package:buzzer/models/exam_model.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final Exam event;
  const EventTile({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(event.title),
          subtitle: Text(event.date.toString()),
        ),
      ),
    );
  }
}
