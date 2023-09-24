import 'package:flutter/material.dart';

ThemeData lightMode() {
  return ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 99, 92, 92),
    ),
  );
}
