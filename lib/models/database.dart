import 'package:hive_flutter/adapters.dart';
import 'package:learn_chinese/models/word.dart';

class Database {
  final sentenceBox = Hive.box('sentences');
  final wordBox = Hive.box('word');

  void setWord(Word word) {
    wordBox.put('word', word.toJson());
  }

  getWord() {
    return wordBox.get('word', defaultValue: "null");
  }

  void setSentences(List<Map<String, String>> sentences) {
    sentenceBox.put('sentences', sentences);
  }

  List<dynamic> getSentences() {
    return sentenceBox.get('sentences', defaultValue: []);
  }

  void clearSentences() {
    sentenceBox.delete("sentences");
  }

  void clearWord() {
    wordBox.delete("word");
  }
} 
