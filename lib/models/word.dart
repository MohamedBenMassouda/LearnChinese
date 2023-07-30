import 'dart:math';

class Word {
  String word;
  String meaning;
  String example;

  Word({
    required this.word,
    required this.meaning,
    required this.example
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['chineseChar'],
      meaning: json['howToRead'],
      example: json['englishEquivalent'],
    );
  }

  factory Word.getRandomWord(List<Word> words) {
    Random random = Random();

    int index = random.nextInt(words.length);
    return words[index];
  }

  Map<String, dynamic> toJson() {
    return {
      'chineseChar': word,
      'howToRead': meaning,
      'englishEquivalent': example,
    };
  }
}
