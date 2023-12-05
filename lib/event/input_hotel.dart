import 'dart:math';
import 'package:flutter/material.dart';

import 'package:hotel_pbp/client/transaction_client.dart';

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
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
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
                        const SizedBox(width: 65),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 175, 61, 49),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Text(
                            'Input Your Room',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      key: const Key('Name'),
                      controller: controllerName,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.badge),
                        border: OutlineInputBorder(),
                        labelText: 'Room Name',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Room Name' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      key: const Key('Desc'),
                      controller: controllerDesc,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(),
                        labelText: 'Room Description',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Room Description' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      key: const Key('Rating'),
                      controller: controllerRating,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.star),
                        border: OutlineInputBorder(),
                        labelText: 'Room Rating',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Room Rating' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      key: const Key('Price'),
                      controller: controllerPrice,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.sell),
                        border: OutlineInputBorder(),
                        labelText: 'Room Price',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Room Price' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      key: const Key('Jumlah'),
                      controller: controllerJumlah,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.meeting_room),
                        border: OutlineInputBorder(),
                        labelText: 'Room Quantity',
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter Room Quantity' : null,
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton(
                      key: const Key('input'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (widget.id == null) {
                            await addHotel(); //r
                          } else {
                            await editHotel(widget.id!, widget.assets!);
                          }
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 175, 61, 49),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(fontSize: 18)),
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
      controllerName.text,
      controllerDesc.text,
      controllerPrice.text,
      controllerRating.text,
      controllerJumlah.text,
      'assets/hotel$count.jpg',
    );
  }

  Future<void> editHotel(int id, String assets) async {
    await TransactionClient.update(
      id,
      controllerName.text,
      controllerDesc.text,
      controllerPrice.text,
      controllerRating.text,
      controllerJumlah.text,
      assets,
    );
  }
}
