import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/model/services.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({required this.services, super.key});

  final Services services;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: const Color.fromARGB(255, 230, 96, 81),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  services.imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      services.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      services.description,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
