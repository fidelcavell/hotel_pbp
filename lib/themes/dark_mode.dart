import 'package:flutter/material.dart';

ThemeData darkMode() {
  return ThemeData(
    brightness: Brightness.dark,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
  );
}
