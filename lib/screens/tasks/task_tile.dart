import 'package:buzzer/main.dart';
import 'package:buzzer/models/task_model.dart';
import 'package:buzzer/services/auth_service.dart';
import 'package:buzzer/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final VoidCallback? deleteFunction;

  const TaskTile({
    Key? key,
    required this.task,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final AuthService _auth = AuthService();

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
        title: buildTitle(
          widget.task.title,
          widget.task.category,
          widget.task.complete,
        ),
        subtitle: buildSubtitle(
          widget.task.dueDate.toDate(),
          widget.task.complete,
        ),
        trailing: Checkbox(
          value: widget.task.complete,
          onChanged: (value) async {
            setState(() {
              widget.task.complete = !widget.task.complete;
            });

            await DatabaseService(uid: _auth.toString())
                .completeTask(widget.task.id, widget.task.complete);
          },
          fillColor: MaterialStateProperty.all(BuzzerColors.orange),
          checkColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(2.7),
            ),
          ),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 15.0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        children: <Widget>[
          widget.task.details.isNotEmpty
              ? Text(widget.task.details)
              : const SizedBox(
                  height: 0.0,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {},
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
                onPressed: () async {
                  DatabaseService(uid: _auth.toString())
                      .deleteTask(widget.task.id);
                  setState(() {
                    widget.deleteFunction;
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
    );
  }

  Widget buildTitle(String title, String category, bool complet) {
    return RichText(
      text: TextSpan(
        text: category,
        style: TextStyle(
          color: complet ? BuzzerColors.grey : Colors.black,
          fontSize: 17.0,
          decoration: complet ? TextDecoration.lineThrough : null,
          decorationThickness: 2.0,
          fontStyle: FontStyle.italic,
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

  Widget buildSubtitle(DateTime dueDate, bool complet) {
    return RichText(
      text: TextSpan(
        text: '${DateFormat('dd.MM', 'en_US').format(dueDate)}  ',
        style: TextStyle(
          color: complet ? BuzzerColors.grey : Colors.black,
          fontSize: 13.0,
        ),
        children: dueDate.isAfter(DateTime.now())
            ? null
            : <TextSpan>[
                TextSpan(
                  text: 'OVERDUE',
                  style: TextStyle(
                    color: complet ? BuzzerColors.grey : BuzzerColors.orange,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
      ),
    );
  }
}
