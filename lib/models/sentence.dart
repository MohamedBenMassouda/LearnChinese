import 'dart:math';

import 'package:learn_chinese/models/database.dart';
import 'package:learn_chinese/models/word.dart';

class Sentence {
  String sentence;
  String translation;
  String pinyin;

  Sentence(
      {required this.sentence,
      required this.translation,
      required this.pinyin});

  factory Sentence.fromJson(Map<String, dynamic> json) {
    return Sentence(
      sentence: json['chinese'],
      translation: json['english'],
      pinyin: json['pinyin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'chinese': sentence, 'english': translation, 'pinYin': pinyin};
  }

  factory Sentence.getRandomSentence(List<Sentence> sentences, Word word) {
    final random = Random();

    int index = 0;
    while (true) {
      index = random.nextInt(sentences.length);

      if (sentences[index].sentence.contains(word.chinese)) {
        break;
      } else {
        sentences.removeAt(index);
      }
    }

    return sentences[index];
  }
}
