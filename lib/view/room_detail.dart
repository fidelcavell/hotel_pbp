import 'package:flutter/material.dart';

class RoomDetail extends StatelessWidget {
  const RoomDetail({required this.type, required this.imagePath, super.key});

  final String type, imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(type),
    );
  }
}
