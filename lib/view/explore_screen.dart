import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:get/get.dart';

import 'package:hotel_pbp/components/image_carousel.dart';
import 'package:hotel_pbp/components/model/facilities.dart';
import 'package:hotel_pbp/components/model/services.dart';
import 'package:hotel_pbp/components/facilities/facilities_list.dart';
import 'package:hotel_pbp/components/services/services.list.dart';
import 'package:hotel_pbp/view/review_screen.dart';
import 'package:hotel_pbp/components/loading_indicator.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Facilities> facilities = [
    Facilities(
      icon: Icons.wind_power_outlined,
      description: 'AC',
    ),
    Facilities(
      icon: Icons.restaurant,
      description: 'Restaurant',
    ),
    Facilities(
      icon: Icons.pool,
      description: 'Swim Pool',
    ),
    Facilities(
      icon: Icons.fitness_center,
      description: 'Gym',
    ),
    Facilities(
      icon: Icons.map_outlined,
      description: 'Strategic',
    ),
    Facilities(
      icon: Icons.local_parking,
      description: 'Parking',
    ),
    Facilities(
      icon: Icons.wifi,
      description: 'Wifi',
    ),
    Facilities(
      icon: Icons.desk,
      description: '24 Hours',
    ),
  ];

  List<Services> services = [
    Services(
      imagePath: 'assets/bodyMessage.jpg',
      title: 'Body Messaging',
      description: 'Relaxing your body from any outside activity',
    ),
    Services(
      imagePath: 'assets/breakfast.jpg',
      title: 'Breakfast',
      description: 'Prepare and start your day with healthy delicious food',
    ),
    Services(
      imagePath: 'assets/extraBed.jpg',
      title: 'Extra Bed',
      description: 'Get extra comfort experience with extra bed',
    ),
  ];
  bool _loading = false;

  //* To show Loading Screen indicator :
  void _onLoading() {
    setState(() {
      _loading = true;
      Future.delayed(const Duration(seconds: 1), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _onLoading();
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        // Show a pop-up dialog to contact customer service
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Contact Customer Service'),
              content: const Text('Do you want to contact customer service?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Contact'),
                  onPressed: () {
                    // Add your code to initiate the contact with customer service here.
                    // You can launch a phone call or open a contact form, for example.
                    // Remember to implement this functionality.
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
    // detector.stopListening();
  }

  void _createNewReview() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const ReviewScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: const Color.fromARGB(255, 230, 96, 81),
        foregroundColor: Colors.white,
        title: const Text('Explore'),
        actions: [
          IconButton(
            onPressed: _createNewReview,
            icon: const Icon(Icons.note_alt),
            tooltip: 'Add Review',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.library_books_sharp),
            tooltip: 'Review',
          ),
          IconButton(
            icon: Get.isDarkMode
                ? const Icon(Icons.nightlight_outlined)
                : const Icon(Icons.sunny),
            onPressed: () {
              setState(() {
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              });
            },
          ),
        ],
      ),
      body: _loading
          ? const LoadingIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const ImageCarousel(),
                  const SizedBox(height: 8.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Atma Hotel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_border_rounded,
                                  size: 30,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  '5.0',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                            'Rasakan kemewahan dan kenyamanan menginap dengan nuansa khas Yogyakarta yang memberikan kenangan tak terlupakan.'),
                        SizedBox(height: 16.0),
                        Text(
                          'Facilities',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Expanded(
                      child: FacilitiesList(facilities: facilities),
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Services',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Expanded(
                    child: ServicesList(services: services),
                  ),
                ],
              ),
            ),
    );
  }
}
