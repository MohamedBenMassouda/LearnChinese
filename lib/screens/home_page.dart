import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn_chinese/models/database.dart';
import 'package:learn_chinese/models/sentence.dart';
import 'package:learn_chinese/models/word.dart';
import 'package:learn_chinese/utils/scrape_sentences.dart';
import 'package:learn_chinese/widgets/sentence_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts flutterTts = FlutterTts();
  List<Word> words = [];
  List<Sentence> sentences = [];
  Database db = Database();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTts();
    readFromFile();
  }

  void initTts() async {
    await flutterTts.setLanguage('zh-CN');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  void readFromFile() async {
    final json = await rootBundle.loadString("assets/chinese.json");
    final List<dynamic> data = jsonDecode(json);

    setState(() {
      words = data.map((e) => Word.fromJson(e)).toList();
    });
  }

  void readFromSentenceFile() async {
    await getSentences(word!.word);

    final data = db.getSentences();

    setState(() {
      sentence = Sentence.getRandomSentence(data.map((e) => Sentence.fromJson(e)).toList());
    });
  }

  Word? word;
  Sentence? sentence;

  @override
  Widget build(BuildContext context) {
    if (words.isNotEmpty && word == null) {
      word = Word.getRandomWord(words);
      readFromSentenceFile();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      // body: Center(
      //   child: word == null ? const Text('Home Page') : WordTile(word: word!),
      // ),
      body: Center(
          child: sentence == null
              ? const SizedBox()
              : SentenceTile(
                  sentence: sentence!,
                  word: word!,
                )),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await flutterTts.speak(word!.word);
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
