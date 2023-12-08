import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/facilities/facilities_list.dart';
import 'package:hotel_pbp/components/model/facilities.dart';
import 'package:hotel_pbp/components/model/services.dart';
import 'package:shake/shake.dart';

import 'package:hotel_pbp/components/image_carousel.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Facilities> facilities = [
    Facilities(
      icon: Icons.ac_unit,
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
  ];

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 61, 49),
        title: const Center(
          child: Text('Explore'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            const ImageCarousel(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Atma Hotel',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_border_rounded),
                          Text(
                            '5.0',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                      'Rasakan kemewahan dan kenyamanan menginap dengan nuansa khas Yogyakarta yang memberikan kenangan tak terlupakan.'),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Facilitiess',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: FacilitiesList(facilities: facilities),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
