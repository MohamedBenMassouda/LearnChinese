import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learn_chinese/models/sentence.dart';
import 'package:learn_chinese/models/word.dart';
import 'package:learn_chinese/utils/generate_random_color.dart';

class SentenceTile extends StatelessWidget {
  final Word word;
  final Sentence sentence;
  final void Function()? onPressed;

  const SentenceTile({
    super.key,
    required this.word,
    required this.sentence,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final int wordIndex = sentence.sentence.indexOf(word.chinese);

    if (wordIndex == -1) {
      return Container(
        child: Column(
          children: [
            const Text(
              "Error: Word not found in sentence",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text("Get a new Word"),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: generateRandomColorFromList(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: sentence.sentence));
            },
            child: RichText(
              text: TextSpan(
                text: sentence.sentence.substring(0, wordIndex),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: sentence.sentence.substring(
                      wordIndex,
                      wordIndex + word.chinese.length,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _showDetailsPopup(context, word);
                      },
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.cyan,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted,
                      decorationColor: Colors.cyan,
                    ),
                  ),
                  TextSpan(
                    text: sentence.sentence.substring(
                      wordIndex + word.chinese.length,
                    ),
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              sentence.pinyin,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
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
            await FlutterTts().speak(word.chinese);
          },
          child: Row(
            children: [
              Text(
                word.chinese,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                  decorationColor: Colors.cyan,
                ),
              ),
              const Spacer(),
              Text(word.pinyin,
                  style: const TextStyle(
                    fontSize: 20,
                  ))
            ],
          ),
        ), // Customize the title if needed
        content: Text(
          word.english,
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
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
