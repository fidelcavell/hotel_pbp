import 'package:flutter/material.dart';

import 'package:hotel_pbp/components/model/facilities.dart';
import 'package:hotel_pbp/components/facilities/facilities_card.dart';

class FacilitiesList extends StatelessWidget {
  const FacilitiesList({required this.facilities, super.key});

  final List<Facilities> facilities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          FacilitiesCard(facilities: facilities[index]),
      itemCount: facilities.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
