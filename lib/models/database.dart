import 'package:hive_flutter/adapters.dart';

class Database {
  final box = Hive.box('sentences');

  void setSentences(List<Map<String, String>> sentences) {
    box.put('sentences', sentences);
  }

  List<dynamic> getSentences() {
    return box.get('sentences');
  }
} 
