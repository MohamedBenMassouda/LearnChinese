import 'dart:math';

class Word {
  String chinese;
  String pinyin;
  String english;

  Word({
    required this.chinese,
    required this.pinyin,
    required this.english
  });

  factory Word.fromJson(Map<dynamic, dynamic> json) {
    return Word(
      chinese: json['chineseChar'],
      pinyin: json['howToRead'],
      english: json['englishEquivalent'],
    );
  }

  factory Word.getRandomWord(List<Word> words) {
    Random random = Random();

    int index = random.nextInt(words.length);
    return words[index];
  }

  Map<String, dynamic> toJson() {
    return {
      'chineseChar': chinese,
      'howToRead': pinyin,
      'englishEquivalent': english,
    };
  }
}
