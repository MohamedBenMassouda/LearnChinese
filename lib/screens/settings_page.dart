import 'package:flutter/material.dart';
import 'package:learn_chinese/models/database.dart';
import 'package:learn_chinese/services/notification_service.dart';
import 'package:learn_chinese/utils/toast_snack_bar.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Page'),
      ),
      body: Center(
        child: Column(
          children: [
            // Word Schedule Time
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      if (value == null) return;

                      if (db.getWordNotificationTime() != "null") {
                        NotificationsServices().cancelScheduledNotifications();
                      }

                      db.setWordNotificationTime(value.format(context));
                      mySnackBar(context,
                          "Word Schedule Time Set to ${value.format(context)}");
                      setState(() {});
                      NotificationsServices().scheduleNotification(
                          title: "Learn Chinese",
                          body: "Learn a new word today!",
                          payload: "payload",
                          scheduledDate: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            value.hour,
                            value.minute,
                          ));
                    });
                  },
                  child: const Text('Word Schedule Time'),
                ),
                const Spacer(),
                Text(
                  db.getWordNotificationTime() == "null"
                      ? "Not Set"
                      : db.getWordNotificationTime(),
                )
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Schedule Notification'),
            )
          ],
        ),
      ),
    );
  }
}
