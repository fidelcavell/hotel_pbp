import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final int _cells = 10;
  final double _containerSizeSmall = 170;
  final double _containerheightSizeLarge = 250;
  final double _containerWidthSizeLarge = 360;
  int _clicked = 0;

  final List<String> _imagePaths = [
    'assets/hotel1.jpg',
    'assets/hotel2.jpg',
    'assets/hotel3.jpg',
    'assets/hotel4.jpg',
    'assets/hotel5.jpg',
    'assets/hotel6.jpg',
    'assets/hotel7.jpg',
    'assets/hotel8.jpg',
    'assets/hotel9.jpg',
    'assets/hotel10.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 61, 49),
        title: const Center(
          child: Text('Explore'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 700,
                  child: Wrap(
                    spacing: 5,
                    children: List.generate(
                      _cells,
                      (col) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _clicked != col + 1
                                    ? _clicked = col + 1
                                    : _clicked = 0;
                              });
                            },
                            child: SizedBox(
                              height: _clicked == col + 1
                                  ? _containerheightSizeLarge
                                  : _containerSizeSmall,
                              width: _clicked == col + 1
                                  ? _containerWidthSizeLarge
                                  : _containerSizeSmall,
                              child: _clicked == col + 1
                                  ? Image.asset(
                                      _imagePaths[col % _imagePaths.length],
                                    )
                                  : Center(
                                      child: Image.asset(
                                        _imagePaths[col % _imagePaths.length],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
