import 'package:buzzer/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timezone;

class NotificationClass {
  Future<void> setReminder(
      int id, String title, String? body, DateTime date) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'channel for alarm notifications',
      importance: Importance.max,
      icon: 'buzzer_icon',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      (title.compareTo('None') == 0) ? 'Buzzer' : title,
      body,
      date.isAfter(DateTime.now())
          ? timezone.TZDateTime.from(date, timezone.local)
          : timezone.TZDateTime.from(
              date.add(const Duration(days: 1)), timezone.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
