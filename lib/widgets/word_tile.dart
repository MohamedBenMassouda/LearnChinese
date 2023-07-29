import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_chinese/models/word.dart';
import 'package:learn_chinese/utils/generate_random_color.dart';

class WordTile extends StatelessWidget {
  final Word word;

  const WordTile({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: generateRandomColor(),
        // gradient: LinearGradient(
        //   colors: [
        //     generateRandomColor(),
        //     generateRandomColor(),
        //   ],
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: word.word));
            },
            child: Text(
              word.word,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
          Text(
            word.meaning,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[100],
            ),
          ),
          const Spacer(),
          Text(
            word.example,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
