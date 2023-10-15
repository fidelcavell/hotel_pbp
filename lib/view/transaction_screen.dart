import 'package:flutter/material.dart';

//import '../database/sql_helper.dart';
import '../database/sql_hotel_controller.dart';
import '../event/input_hotel.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Map<String, dynamic>> hotelRoom = [];
  bool isFavorite = false;

  void refresh() async {
    final data = await SQLHotelController.getHotel();
    setState(() {
      hotelRoom = data;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 175, 61, 49)),
            width: double.infinity,
            child: const Center(
              child: Text(
                'Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InputHotel(
                              id: null,
                              assets: null,
                              name: null,
                              desc: null,
                              rating: null,
                              price: null,
                              jumlah: null),
                        )).then((_) => refresh());
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Hotel room'),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hotelRoom.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(120, 175, 61, 49),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(hotelRoom[index]['assets']),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                hotelRoom[index]['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star),
                                      const SizedBox(width: 8.0),
                                      Text(hotelRoom[index]['rating']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.hotel),
                                      const SizedBox(width: 8.0),
                                      Text(hotelRoom[index]['rating']),
                                      const Text(' / Night'),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                hotelRoom[index]['description'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.bed),
                                  const SizedBox(width: 8.0),
                                  const Text('Jumlah : '),
                                  Text(hotelRoom[index]['jumlah']),
                                  const Text(' Kamar'),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Colors.yellow.withOpacity(0.5),
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(Icons.update),
                                      label: const Text('Update'),
                                    ),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Colors.red.withOpacity(0.5),
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete),
                                      label: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
