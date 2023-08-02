import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

// {} is used to make the parameter optional
void mySnackBar(context, String text,
    {Color color = const Color.fromARGB(255, 42, 41, 41)}) {
  BotToast.showCustomText(
    toastBuilder: (_) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    duration: const Duration(seconds: 3),
    crossPage: true,
    clickClose: true,
    backButtonBehavior: BackButtonBehavior.ignore,
    enableKeyboardSafeArea: true,
  );
}

