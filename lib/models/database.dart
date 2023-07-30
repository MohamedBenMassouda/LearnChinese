import 'package:hive_flutter/adapters.dart';
import 'package:learn_chinese/models/word.dart';

class Database {
  final sentenceBox = Hive.box('sentences');
  final wordBox = Hive.box('word');

  void setWord(Word word) {
    sentenceBox.put('word', word.toJson());
  }

  String getWord() {
    String? word = wordBox.get('word');

    return word ?? "null";
  }

  void setSentences(List<Map<String, String>> sentences) {
    sentenceBox.put('sentences', sentences);
  }

  List<dynamic> getSentences() {
    return sentenceBox.get('sentences');
  }
} 
