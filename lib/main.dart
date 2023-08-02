import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:learn_chinese/screens/home_page.dart';
import 'package:learn_chinese/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('sentences');
  await Hive.openBox('word');
  await Hive.openBox('settings');

  NotificationsServices().initNotification();
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
