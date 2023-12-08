import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentIndex = 0;

  final List<String> _imagePaths = [
    'assets/hotel1.jpg',
    'assets/hotel2.jpg',
    'assets/hotel7.jpg',
    'assets/hotel8.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    //* Carousel Image Slider :
    return Stack(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Image.asset(
                _imagePaths[index % _imagePaths.length],
                fit: BoxFit.cover,
              );
            },
            onPageChanged: (index) {
              setState(() {
                currentIndex = index % _imagePaths.length;
              });
            },
          ),
        ),
        Positioned(
          top: 140,
          left: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _imagePaths.length; i++)
                buildIndicator(currentIndex == i)
            ],
          ),
        )
      ],
    );
  }

  //* Carousel Image's Indicator :
  Widget buildIndicator(bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: isSelected ? 10 : 8,
      width: isSelected ? 30 : 8,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isSelected
              ? const Color.fromARGB(255, 230, 96, 81)
              : const Color.fromARGB(255, 102, 89, 89),
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
