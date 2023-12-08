import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/model/services.dart';
import 'package:hotel_pbp/components/services/services_card.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({required this.services, super.key});

  final List<Services> services;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          
        },
        child: ServiceCard(services: services[index]),
      ),
      itemCount: services.length,
    );
  }
}
