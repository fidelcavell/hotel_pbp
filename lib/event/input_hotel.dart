import 'package:flutter/material.dart';
import 'dart:math';

import '../database/sql_hotel_controller.dart';

final randomizer = Random();

class InputHotel extends StatefulWidget {
  const InputHotel({
    super.key,
    required this.id,
    required this.assets,
    required this.name,
    required this.desc,
    required this.rating,
    required this.price,
    required this.jumlah,
  });

  final int? id;
  final String? assets, name, desc, rating, price, jumlah;

  @override
  State<InputHotel> createState() => _InputHotelState();
}

class _InputHotelState extends State<InputHotel> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerRating = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  int count = randomizer.nextInt(10) + 1;

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      controllerName.text = widget.name!;
      controllerDesc.text = widget.desc!;
      controllerRating.text = widget.rating!;
      controllerPrice.text = widget.price!;
      controllerJumlah.text = widget.jumlah!;
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset(widget.id != null
                    ? widget.assets!
                    : 'assets/hotel$count.jpg'),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextField(
                    controller: controllerName,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nama Kamar',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controllerDesc,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Desc Kamar',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controllerRating,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Rating Kamar',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controllerPrice,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Harga Kamar',
                    ),
                  ),
                  TextField(
                    controller: controllerJumlah,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Jumlah Kamar',
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.id == null) {
                        await addHotel(); //r
                      } else {
                        await editHotel(widget.id!, widget.assets!);
                      }

                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addHotel() async {
    await SQLHotelController.addHotel(
      'assets/hotel$count.jpg',
      controllerName.text,
      controllerDesc.text,
      controllerRating.text,
      controllerPrice.text,
      controllerJumlah.text,
    );
  }

  Future<void> editHotel(int id, String assets) async {
    await SQLHotelController.editHotel(
      id,
      assets,
      controllerName.text,
      controllerDesc.text,
      controllerRating.text,
      controllerPrice.text,
      controllerJumlah.text,
    );
  }
}
