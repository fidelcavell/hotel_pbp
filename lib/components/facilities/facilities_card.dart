import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/model/facilities.dart';

class FacilitiesCard extends StatelessWidget {
  const FacilitiesCard({required this.facilities, super.key});

  final Facilities facilities;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 230, 96, 81),
      child: SizedBox(
        height: 80,
        width: 80,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              Icon(
                facilities.icon,
                color: Colors.white,
              ),
              const SizedBox(height: 8.0),
              Text(
                facilities.description,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
