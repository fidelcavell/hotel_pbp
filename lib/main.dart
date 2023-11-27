import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hotel_pbp/view/login_view.dart';
import 'package:hotel_pbp/themes/dark_mode.dart';
import 'package:hotel_pbp/themes/light_mode.dart';

import 'package:hotel_pbp/view/main_screen.dart';
import 'package:hotel_pbp/view/register_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
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
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        Device.orientation == Orientation.portrait
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5.h,
              );
        Device.screenType == ScreenType.tablet
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5.h,
              );
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeMode ? darkMode() : lightMode(),
          home: Scaffold(
            appBar: AppBar(
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
      },
    );
  }
}
