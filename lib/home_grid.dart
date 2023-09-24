import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'material_indicator_design.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      itemCount: 12,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset('lib/images/hotel${index + 1}.jpg'),
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>  with SingleTickerProviderStateMixin{
  
  late TabController _tabController;
  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  final _tabs =[
    Tab(text: 'Tab 1'),
    Tab(text: 'Tab 2'),
    Tab(text: 'Tab 3'),
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
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedColor,
        title: Text("ini taskbar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              height: kToolbarHeight - 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TabBar(
              controller: _tabController,
              labelColor: _selectedColor,
              unselectedLabelColor: _unselectedColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: MaterialDesignIndicator(
                  indicatorHeight: 4, indicatorColor: _selectedColor),
              tabs: _tabs,
            ),
            )
          ]

          .map((item) => Column(
            children: [
              item,
              Divider(
                color: Colors.transparent,
              )
            ],
          ))
          .toList(),
        ),
      ),
    );
  }
}