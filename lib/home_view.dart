import 'package:flutter/material.dart';

import 'package:hotel_pbp/home_grid.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _selectedColor = const Color(0xff1a73e8);

  final _iconTabs = const [
    Tab(icon: Icon(Icons.chat)),
    Tab(icon: Icon(Icons.call)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(buildContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedColor,
        title: const Text("Taskbar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          TabBar(
            controller: _tabController,
            tabs: _iconTabs,
            unselectedLabelColor: Colors.black,
            labelColor: _selectedColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              color: _selectedColor.withOpacity(0.2),
            ),
          ),
        ]),
      ),
    );
  }
}
