import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn_chinese/models/database.dart';
import 'package:learn_chinese/models/sentence.dart';
import 'package:learn_chinese/models/word.dart';
import 'package:learn_chinese/screens/settings_page.dart';
import 'package:learn_chinese/utils/scrape_sentences.dart';
import 'package:learn_chinese/widgets/sentence_tile.dart';
import 'package:learn_chinese/widgets/word_tile.dart';

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
    super.initState();
    initTts();
    readFromFile();

    if (db.getLastTimeAccessed() == "null") {
      db.setLastTimeAccessed(DateTime.now());
    } else {
      final lastTimeAccessed = db.getLastTimeAccessed();
      final now = DateTime.now();

      if (now.difference(lastTimeAccessed).inDays >= 1) {
        db.setLastTimeAccessed(now);
        db.clearWord();
        db.clearSentences();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterTts.stop();
  }

  void initTts() async {
    await flutterTts.setLanguage('zh-CN');
    await flutterTts.setSpeechRate(speechValue);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> readFromFile() async {
    final json = await rootBundle.loadString("assets/chinese.json");
    final List<dynamic> data = jsonDecode(json);

    setState(() {
      words = data.map((e) => Word.fromJson(e)).toList();

      if (db.getWord() != "null") {
        word = Word.fromJson(db.getWord());
      } else {
        word = Word.getRandomWord(words);
        db.setWord(word!);
      }

      readFromSentenceFile();
    });
  }

  void readFromSentenceFile() async {
    if (!db.getWordIsViewed()) {
      return;
    }

    if (db.getSentences().isEmpty) {
      await getSentences(word!.chinese);
    }

    final data = db.getSentences();

    setState(() {
      for (var item in data) {
        if (item["chinese"].toString().trim() == "" ||
            !item["chinese"].toString().contains(word!.chinese)) continue;

        sentences.add(
          Sentence(
            sentence: item['chinese'],
            translation: item['english'],
            pinyin: item['pinyin'],
          ),
        );
      }

      sentence = Sentence.getRandomSentence(sentences, word!);
    });
  }

  Word? word;
  Sentence? sentence;
  double speechValue = 0.5;

  @override
  Widget build(BuildContext context) {
    final isViewed = db.getWordIsViewed();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                db.clearAll();
                sentence = null;
                word = Word.getRandomWord(words);
                db.setWord(word!);
                db.setWordIsViewed(false);
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isViewed || word == null ? const SizedBox() : WordTile(word: word!),

            sentence == null
                ? isViewed
                    ? const Text('Loading...')
                    : const SizedBox()
                : SentenceTile(
                    sentence: sentence!,
                    word: word!,
                    onPressed: () {
                      db.clearAll();
                      db.setWordIsViewed(false);
                      setState(() {
                        sentence = null;
                        word = Word.getRandomWord(words);
                        db.setWord(word!);
                      });
                    },
                  ),

            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isViewed
                    ? const SizedBox()
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            db.setWordIsViewed(true);
                            readFromSentenceFile();
                          });
                        },
                        child: const Text('Mark as Viewed'),
                      ),
                ElevatedButton(
                  onPressed: () {
                    if (sentence == null) {
                      db.clearAll();
                      setState(() {
                        word = Word.getRandomWord(words);
                        db.setWord(word!);
                      });
                      return;
                    }

                    setState(() {
                      sentence = null;
                    });

                    readFromSentenceFile();
                  },
                  child: const Text("Next"),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            // Slider for the speed of speech
            const Text(
              'Speech Rate',
              style: TextStyle(
                fontSize: 20,
              ),
            ),

            Slider(
              value: speechValue,
              min: 0.1,
              max: 1.0,
              divisions: 9,
              label: speechValue.toString(),
              onChanged: (value) async {
                setState(() {
                  speechValue = value;
                });

                await flutterTts.setSpeechRate(speechValue);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (sentence == null) {
            await flutterTts.speak(word!.chinese);
          } else {
            await flutterTts.speak(sentence!.sentence);
          }
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
