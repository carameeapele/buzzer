import 'package:buzzer/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

final preferences = Hive.box('preferences');
final darkMode = preferences.get('darkMode', defaultValue: false);

Card customCard(Widget child) {
  return Card(
    color: darkMode ? BuzzerColors.grey : BuzzerColors.lightGrey,
    elevation: 0.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    child: child,
  );
}

RichText taskTitle(
  String title,
  String category,
  DateTime date,
  bool complete,
) {
  return RichText(
    text: TextSpan(
      text: (category.compareTo('None') == 0) ? '' : '$category  ',
      style: TextStyle(
        color: complete
            ? BuzzerColors.grey
            : (darkMode ? Colors.white : Colors.black),
        fontSize: 17.0,
        decoration: complete ? TextDecoration.lineThrough : null,
        decorationThickness: 2.0,
        fontStyle: FontStyle.italic,
      ),
      children: <TextSpan>[
        TextSpan(
          text: title,
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

RichText taskSubtitle(
  bool complete,
  DateTime date,
  DateTime time,
) {
  DateTime now = DateTime.now();
  bool _isBefore = (date.isBefore(now));
  bool _isToday =
      (date.day == now.day && date.month == now.month && date.year == now.year);

  return RichText(
    text: TextSpan(
      text: _isToday
          ? '${DateFormat('Hm').format(time)}  '
          : '${DateFormat('dd MMM', 'en_US').format(date)}  ',
      style: TextStyle(
        color: complete ? BuzzerColors.grey : Colors.black,
        fontSize: 13.0,
      ),
      children: (_isBefore && time.isBefore(now))
          ? <TextSpan>[
              TextSpan(
                text: 'OVERDUE',
                style: TextStyle(
                  color: complete ? BuzzerColors.grey : BuzzerColors.orange,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]
          : null,
    ),
  );
}
