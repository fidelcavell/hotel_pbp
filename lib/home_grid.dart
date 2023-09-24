import 'package:flutter/material.dart';
//import 'material_indicator_design.dart';

class HomeGridView extends StatefulWidget {
  const HomeGridView({super.key});

  @override
  State<HomeGridView> createState() => _HomeGridViewState();
}

class _HomeGridViewState extends State<HomeGridView> {
  final int _cells = 12;
  final double _containerSizeSmall = 170;
  final double _containerheightSizeLarge = 250;
  final double _containerWidthSizeLarge = 360;
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
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: 700,
          child: Wrap(
            spacing: 5,
            children: List.generate(
              _cells,
              (col) => Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _clicked != col + 1 ? _clicked = col + 1 : _clicked = 0;
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
    );
  }
}
