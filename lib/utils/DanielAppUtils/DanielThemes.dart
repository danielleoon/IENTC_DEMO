import 'package:flutter/material.dart';

class ThemeConfig {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColorDark: Colors.black,
    primaryColor: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColorDark: Colors.white,
    primaryColor: Colors.deepOrange,
    cardColor: const Color.fromARGB(255, 44, 44, 44),
    scaffoldBackgroundColor: const Color.fromARGB(255, 44, 44, 44),
  );
}
