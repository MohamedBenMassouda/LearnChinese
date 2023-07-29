import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn_chinese/models/sentence.dart';
import 'package:learn_chinese/models/word.dart';
import 'package:learn_chinese/utils/generate_random_color.dart';

class SentenceTile extends StatelessWidget {
  final Word word;
  final Sentence sentence;

  const SentenceTile({
    super.key,
    required this.word,
    required this.sentence,
  });

  @override
  Widget build(BuildContext context) {
    final int wordIndex = sentence.sentence.indexOf(word.word);

    return Container(
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: generateRandomColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: sentence.sentence));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sentence.sentence.substring(0, wordIndex),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _showDetailsPopup(context, word);
                  },
                  child: Text(
                    word.word,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted,
                      decorationColor: Colors.cyan,
                    ),
                  ),
                ),
                Text(
                  sentence.sentence.substring(wordIndex + 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sentence.translation,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[100],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              sentence.pinyin,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

void _showDetailsPopup(BuildContext context, Word word) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: InkWell(
          onTap: () async {
            await FlutterTts().speak(word.word);
          },
          child: Text(
            word.word,
            style: const TextStyle(
              color: Colors.cyan,
              fontSize: 30,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: Colors.cyan,
            ),
          ),
        ), // Customize the title if needed
        content: Text(
          word.example,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ), // Customize the content with the desired details
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // To close the popup
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

