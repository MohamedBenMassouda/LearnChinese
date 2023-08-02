import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationsServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initNotification() async {
    final AndroidFlutterLocalNotificationsPlugin?
        androidFlutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    androidFlutterLocalNotificationsPlugin?.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('images');

    var initializationSettings =
        const InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: payload,
    );
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime scheduledDate}) async {
    return flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  Future<void> scheduleNotificationHourly() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      "Learn Chinese",
      "Learn a new word today!",
      RepeatInterval.hourly,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  tz.TZDateTime nextInstanceOfTime(DateTime time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  void cancelScheduledNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
