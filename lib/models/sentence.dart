import 'dart:math';

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


  factory Sentence.getRandomSentence(List<Sentence> sentences) {
    final random = Random();
    final index = random.nextInt(sentences.length);
    return sentences[index];
  }
}
