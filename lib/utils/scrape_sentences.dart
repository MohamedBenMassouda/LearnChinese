import 'dart:math';

import 'package:learn_chinese/models/database.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:learn_chinese/models/sentence.dart';

Future<void> getSentences(String query, {int page = 1}) async {
  String url = "https://www.chineseboost.com/chinese-example-sentences?query=$query&page=$page";

  var response = await http.get(Uri.parse(url)); 
  var htmlDoc = parser.parse(response.body);
  
  var cards = htmlDoc.querySelectorAll('.card-body');

  List<Map<String, String>> sentences = [];

  for (var card in cards) {
    var chinese = card.querySelector('.hanzi')?.text;
    var pinyin = card.querySelector('.pinyin')?.text;
    var english = card.querySelector('.yingwen')?.text;

    if (chinese != null && pinyin != null && english != null) {
      sentences.add(
        {
          'chinese': chinese,
          'pinyin': pinyin,
          'english': english
        }
      );
    }
  }

  Database().setSentences(sentences);
}


Sentence getRandomSentence(List<Sentence> sentences) {
  return sentences[Random().nextInt(sentences.length)];
}
