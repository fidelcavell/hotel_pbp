import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import './explore_screen.dart';
import './transaction_screen.dart';
import './user_profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentScreen = 'Explore-screen';

  @override
  Widget build(buildContext) {
    Widget currentWidget = const ExploreScreen();

    if (currentScreen == 'Explore-screen') {
      currentWidget = const ExploreScreen();
    } else if (currentScreen == 'Transaction-screen') {
      currentWidget = const TransactionScreen();
    } else if (currentScreen == 'Profile-screen') {
      currentWidget = const UserProfile();
    }

    return MaterialApp(
        home: Scaffold(
      body: currentWidget,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 175, 61, 49),
            borderRadius: BorderRadius.circular(20.0)),
        child: GNav(
            gap: 10,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.withOpacity(0.2),
            onTabChange: (value) {
              setState(() {
                if (value == 0) {
                  currentScreen = 'Explore-screen';
                } else if (value == 1) {
                  currentScreen = 'Transaction-screen';
                } else if (value == 2) {
                  currentScreen = 'Profile-screen';
                }
              });
            },
            tabs: const [
              GButton(icon: Icons.explore, text: 'Explore'),
              GButton(icon: Icons.receipt, text: 'Transaction'),
              GButton(icon: Icons.person, text: 'Profile'),
            ]),
      ),
    ));
  }
}
