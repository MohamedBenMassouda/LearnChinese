import 'dart:math';

import 'package:flutter/material.dart';

List<Color> colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.indigo,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];

Color generateRandomColor() {
  int red = Random().nextInt(255);
  int green = Random().nextInt(255);
  int blue = Random().nextInt(255);
  int opacity = Random().nextInt(255);

  return Color.fromARGB(opacity < 150 ? 150 : opacity, red, green, blue);
}

Color generateRandomColorFromList() {
  Random random = Random();
  int index = random.nextInt(colors.length);
  return colors[index];
}
