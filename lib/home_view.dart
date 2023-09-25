import 'package:flutter/material.dart';

import 'package:hotel_pbp/home_grid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final _selectedColor = const Color.fromARGB(255, 255, 255, 255);

  final _iconTabs = const [
    Tab(icon: Icon(Icons.photo)),
    Tab(icon: Icon(Icons.person)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  Widget build(buildContext) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("              Home View"),
          bottom: TabBar(
            tabs: _iconTabs,
            unselectedLabelColor: Colors.black,
            labelColor: _selectedColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              color: _selectedColor.withOpacity(0.2),
            ),
          ),
        ),
        body: const TabBarView(children: [
          HomeGridView(),
          Center(
            child: Text('Tabs 2'),
          ),
          Center(
            child: Text('Tabs 3'),
          )
        ]),
      ),
    );
  }
}
