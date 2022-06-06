import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        margin: const EdgeInsets.only(top: 5.0),
        elevation: 0.0,
        child: ExpansionTile(
          maintainState: true,
          onExpansionChanged: (isExpanded) {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          collapsedBackgroundColor: BuzzerColors.lightGrey,
          backgroundColor: BuzzerColors.orange,
          collapsedTextColor: Colors.black,
          textColor: Colors.white,
          title: Text(widget.task.title),
          trailing: Text(DateFormat('d MMMM', 'en_US')
              .format(widget.task.dueDate.toDate())),
          children: <Widget>[
            Text('Tag: ${widget.task.category}'),
            Text('Details: ${widget.task.details}'),
          ],
        ),
      ),
    );
  }

  Widget buildExpansionTile(bool isExpanded) {
    return ExpansionTile(title: ),
  }
}
