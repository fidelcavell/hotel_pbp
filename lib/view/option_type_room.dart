import 'package:flutter/material.dart';
import 'package:hotel_pbp/components/model/services.dart';
import 'package:hotel_pbp/components/services/services_card.dart';
import 'package:hotel_pbp/view/room_detail.dart';

class OptionTypeRoom extends StatelessWidget {
  const OptionTypeRoom({super.key});

  @override
  Widget build(BuildContext context) {
    List<Services> services = [
      Services(
        imagePath: 'assets/standard.jpg',
        title: 'Standard',
        description: 'Designed to provide comfortable and essential',
      ),
      Services(
        imagePath: 'assets/superior.jpg',
        title: 'Superior',
        description: 'Designed with your utmost relaxation in mind',
      ),
      Services(
        imagePath: 'assets/luxury.jpg',
        title: 'Luxury',
        description:
            'Designed for the discerning traveler, redefines the art of hospitality.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 96, 81),
        foregroundColor: Colors.white,
        title: const Text('Room Type'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ListView.builder(
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RoomDetail(
                    type: services[index].title,
                    imagePath: services[index].imagePath,
                  ),
                ),
              );
            },
            child: ServiceCard(services: services[index]),
          ),
          itemCount: services.length,
        ),
      ),
    );
  }
}
