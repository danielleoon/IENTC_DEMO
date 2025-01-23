import 'package:flutter/material.dart';

class MessageHelper {
  static void showMessage(BuildContext context, String message,
      Color backgroundColor, Color textColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Daniel-Regular',
            color: textColor,
          ),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
