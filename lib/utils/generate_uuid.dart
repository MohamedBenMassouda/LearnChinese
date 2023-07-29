import 'dart:math';

String generateUUID() {
  String uuid = "";
  for (int i = 0; i < 32; i++) {
    if (i == 8 || i == 12 || i == 16 || i == 20) {
      uuid += "-";
    }
    uuid += (Random().nextInt(16)).toRadixString(16);
  }
  
  return uuid;
}
