import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learn_chinese/screens/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('sentences');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
