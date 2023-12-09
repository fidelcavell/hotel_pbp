import 'package:flutter/material.dart';
import 'package:hotel_pbp/event/input_hotel.dart';

class RoomDetail extends StatelessWidget {
  const RoomDetail(
      {required this.type,
      required this.imagePath,
      required this.description,
      super.key});

  final String type, imagePath, description;

  @override
  Widget build(BuildContext context) {
    int price = type == 'Standard'
        ? 350000
        : type == 'Superior'
            ? 750000
            : 2000000;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 96, 81),
        foregroundColor: Colors.white,
        title: const Center(
          child: Text('Detail Room'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(15), // Adjust the radius as needed
              child: Image.asset(
                imagePath, // Replace with your image asset,
                fit: BoxFit.cover,
                width: 372,
                height: 249,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '$type Room',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Center(
                    child: Text(
                      'Description',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Center(
                    child: Text(
                      'Facilities',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 175, 61, 49),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp.$price/Night',
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InputHotel(
                              id: null,
                              assets: imagePath,
                              name: type,
                              desc: null,
                              rating: null,
                              price: price.toString(),
                              jumlah: null),
                        ),
                      );
                    },
                    child: const Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white),
                    ),
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
