import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

final preferences = Hive.box('preferences');
final darkMode = preferences.get('darkMode', defaultValue: false);

Card customCard(Widget child) {
  return Card(
    color: darkMode ? Colors.grey[800] : BuzzerColors.lightGrey,
    elevation: 0.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    child: child,
  );
}

Widget taskTitle(
  String title,
  String category,
  DateTime date,
  bool complete,
) {
  return (category.length > 10)
      ? SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (category.compareTo('None') != 0)
                  Text(
                    category,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18.0,
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        )
      : SizedBox(
          child: Row(
            children: [
              if (category.compareTo('None') != 0)
                Text(
                  '$category  ',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        );
}

Widget taskSubtitle(
  bool complete,
  DateTime date,
  DateTime time,
) {
  DateTime now = DateTime.now();
  bool _isBefore = (date.isBefore(now));
  bool _isToday =
      (date.day == now.day && date.month == now.month && date.year == now.year);

  return SizedBox(
    child: Row(
      children: [
        Text(
          _isToday
              ? '${DateFormat('Hm').format(time)}  '
              : '${DateFormat('dd MMM', 'en_US').format(date)}  ',
          style: const TextStyle(fontSize: 13.0),
        ),
        if (_isBefore && time.isBefore(now))
          Text(
            'OVERDUE',
            style: TextStyle(
              color: BuzzerColors.orange,
              fontWeight: FontWeight.w700,
            ),
          )
      ],
    ),
  );
}

Widget bottomOptions(
  BuildContext context,
  void Function() onSave,
) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: OutlinedTextButtonWidget(
            text: 'Cancel',
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: BuzzerColors.orange,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: FilledTextButtonWidget(
            text: 'Save',
            icon: false,
            onPressed: () {
              onSave();
            },
            backgroundColor: BuzzerColors.orange,
            textColor: Colors.white,
          ),
        ),
      ],
    ),
  );
}
