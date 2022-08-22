import 'package:buzzer/main.dart';
import 'package:buzzer/models/exam_model.dart';
import 'package:flutter/material.dart';

class EventTile extends StatefulWidget {
  final Exam exam;

  const EventTile({
    Key? key,
    required this.exam,
  }) : super(key: key);

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: BuzzerColors.lightGrey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: ExpansionTile(
        title: RichText(
          text: TextSpan(
            text: widget.exam.tag,
            style: TextStyle(
              color: widget.exam.date.toDate().isAfter(DateTime.now())
                  ? Colors.black
                  : BuzzerColors.grey,
              fontSize: 17.0,
              fontStyle: FontStyle.italic,
              decoration: widget.exam.date.toDate().isAfter(DateTime.now())
                  ? null
                  : TextDecoration.lineThrough,
              decorationThickness: 2.0,
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' ${widget.exam.title}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
