import 'package:hive_flutter/adapters.dart';
import 'package:learn_chinese/models/word.dart';

class Database {
  final sentenceBox = Hive.box('sentences');
  final wordBox = Hive.box('word');
  final settingsBox = Hive.box('settings');

  void setWord(Word word) {
    wordBox.put('word', word.toJson());
  }

  getWord() {
    return wordBox.get('word', defaultValue: "null");
  }

  void setWordIsViewed(bool isViewed) {
    wordBox.put('isViewed', isViewed);
  }

  bool getWordIsViewed() {
    return wordBox.get('isViewed', defaultValue: false);
  }

  void setLastTimeAccessed(DateTime time) {
    wordBox.put('lastTimeAccessed', time);
  }

  getLastTimeAccessed() {
    return wordBox.get('lastTimeAccessed', defaultValue: "null");
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

  void setWordNotificationTime(String time) {
    settingsBox.put('wordNotificationTime', time);
  }

  String getWordNotificationTime() {
    return settingsBox.get('wordNotificationTime', defaultValue: "null");
  }

  void clearAll() {
    wordBox.clear();
    sentenceBox.clear();
  }
}
