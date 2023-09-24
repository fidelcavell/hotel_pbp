import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'material_indicator_design.dart';

class HomeGridView extends StatefulWidget {
  const HomeGridView({super.key});

  @override
  State<HomeGridView> createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridView> {
  final int _cells = 12;
  final double _containerSizeSmall = 100;
  final double _containerSizeLarge = 250;
  final double _padding = 4;
  int _clicked = 0;

  final List<String> _imagePaths = [
    'lib/images/hotel1.jpg',
    'lib/images/hotel2.jpg',
    'lib/images/hotel4.jpg',
    'lib/images/hotel5.jpg',
    'lib/images/hotel6.jpg',
    'lib/images/hotel7.jpg',
    'lib/images/hotel8.jpg',
    'lib/images/hotel9.jpg',
    'lib/images/hotel10.jpg',
    'lib/images/hotel11.jpg',
    'lib/images/hotel12.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: 240,
        child: Wrap(
          children: List.generate(
            _cells,
            (col) => Padding(
              padding: EdgeInsets.all(_padding),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _clicked != col + 1 ? _clicked = col + 1 : _clicked = 0;
                  });
                },
                child: Container(
                  height: _clicked == col + 1
                      ? _containerSizeLarge
                      : _containerSizeSmall,
                  width: _clicked == col + 1
                      ? _containerSizeLarge
                      : _containerSizeSmall,
                  child: _clicked == col + 1
                      ? Image.asset(
                          _imagePaths[col %
                              _imagePaths.length], // Use images cyclically
                        )
                      : Center(
                          child: Image.asset(
                            _imagePaths[col %
                                _imagePaths.length], // Use images cyclically
                          ),
                        ),
                ),
              ),
            ),
          ),
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

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);

  final _iconTabs = [
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
