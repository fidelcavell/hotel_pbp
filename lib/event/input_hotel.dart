import 'dart:math';
import 'package:flutter/material.dart';

import 'package:hotel_pbp/client/transaction_client.dart';
import 'package:hotel_pbp/view/transaction_screen.dart';

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
  final formKey = GlobalKey<FormState>();
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 96, 81),
        foregroundColor: Colors.white,
        title: const Text('Booking'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Center(
                      child: Text(
                        '${widget.name!} Room',
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controllerDesc,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.subtitles),
                        border: OutlineInputBorder(),
                        labelText: 'Your Name',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Your name' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controllerRating,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.star),
                        border: OutlineInputBorder(),
                        labelText: 'Your Rating',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Your Rating' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      key: const Key('Jumlah'),
                      controller: controllerJumlah,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.alarm),
                        border: OutlineInputBorder(),
                        labelText: 'Quantity (night)',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Quantity (night)' : null,
                    ),
                    const SizedBox(height: 48),
                    size
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (widget.id == null) {
                            await addHotel(); 
                          } else {
                            await editHotel(
                              widget.id!,
                              widget.assets!,
                              widget.name!,
                              widget.price!,
                            );
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TransactionScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 230, 96, 81),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Save'),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addHotel() async {
    await TransactionClient.create(
      widget.name!,
      controllerDesc.text,
      widget.price!,
      controllerRating.text,
      controllerJumlah.text,
      widget.assets!,
    );
  }

  Future<void> editHotel(
      int id, String assets, String name, String price) async {
    await TransactionClient.update(
      id,
      name,
      controllerDesc.text,
      price,
      controllerRating.text,
      controllerJumlah.text,
      assets,
    );
  }
}
