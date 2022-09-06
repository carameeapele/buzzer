import 'package:buzzer/main.dart';
import 'package:buzzer/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

final preferences = Hive.box('preferences');
final darkMode = preferences.get('darkMode', defaultValue: true);

Card customCard(Widget child, bool border) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      side: BorderSide(
        color: border ? BuzzerColors.orange : Colors.transparent,
        width: 2.0,
      ),
    ),
    child: child,
  );
}

Widget todayTaskTitle(
  String title,
  String category,
  DateTime date,
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
                      fontSize: 16.0,
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
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
                    fontSize: 16.0,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
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
                    fontSize: 16.0,
                  ),
                ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
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
  String category,
) {
  DateTime now = DateTime.now();
  bool _isBefore = (date.isBefore(now));
  bool _isToday =
      (date.day == now.day && date.month == now.month && date.year == now.year);

  return SizedBox(
    child: Padding(
      padding: (category.length > 10)
          ? const EdgeInsets.only(bottom: 10.0)
          : const EdgeInsets.only(bottom: 0.0),
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
            ),
        ],
      ),
    ),
  );
}

Widget todayTitle(
  String firstPart,
  String secondPart,
) {
  return SizedBox(
    child: Row(
      children: <Widget>[
        Text(
          firstPart,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.0,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          secondPart,
        ),
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
            onPressed: onSave,
            backgroundColor: BuzzerColors.orange,
            textColor: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget classTitle(String title, String type) {
  return Row(
    children: <Widget>[
      if (type.compareTo('None') != 0)
        Text(
          '$type ',
          style: const TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget tileOptions(
    BuildContext context, Widget editPage, void Function()? deleteFunction) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => editPage,
            ),
          );
        },
        child: const Text('Edit'),
      ),
      const SizedBox(
        width: 5.0,
      ),
      TextButton(
        onPressed: deleteFunction,
        child: const Text('Delete'),
      ),
    ],
  );
}

Widget classRow(String tag, Widget value) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          tag,
          style: TextStyle(
            color: BuzzerColors.grey,
          ),
        ),
        value,
      ],
    ),
  );
}

Widget defaultScreen(BuildContext context, Icon icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 50.0,
      horizontal: 20.0,
    ),
    width: MediaQuery.of(context).size.width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.grey[300],
        fontSize: 16.0,
      ),
    ),
  );
}
