import 'package:flutter/material.dart';

import 'package:hotel_pbp/login_view.dart';
import 'package:hotel_pbp/themes/dark_mode.dart';
import 'package:hotel_pbp/themes/light_mode.dart';

void main() {
  runApp(const MainApp());
}

var themeMode = false;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeMode ? darkMode() : lightMode(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 175, 61, 49),
          title: const Center(child: Text('Hotel PBP')),
        ),
        body: const LoginView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              themeMode = !themeMode;
            });
          },
          child: Icon(themeMode ? Icons.nights_stay : Icons.wb_sunny),
        ),
      ),
    );
  }
}
