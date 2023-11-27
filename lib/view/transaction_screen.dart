import 'package:flutter/material.dart';
import 'package:hotel_pbp/client/transaction_client.dart';
import 'package:hotel_pbp/client/user_client.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

import '../event/input_hotel.dart';
import 'package:hotel_pbp/pdf/pdf_view.dart';



class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Map<String, dynamic>> hotelRoom = [];
  bool isFavorite = false;
  String id = const Uuid().v1();

  void refresh() async {
    final data = await TransactionClient.fetchAll();
    setState(() {
      hotelRoom = data;
    });
  }

  void getHotelById(int id) {
    for (var i = 0; i < hotelRoom.length; i++) {
      if (hotelRoom[i]['id'] == id) {
        setState(() {
          hotelRoom = [hotelRoom[i]];
        });
        return;
      }
    }
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 61, 49),
        title: const Center(
          child: Text('Transaction'),
        ),
      ),
      body: Column(
        children: [
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
                      refresh();
                    },
                    icon: const Icon(Icons.hotel)),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.all(16.0),
                            child: MobileScanner(
                              fit: BoxFit.fill,
                              onDetect: (barcodes) {
                                if (barcodes.barcodes.isEmpty) {
                                  return;
                                }
                                getHotelById(int.parse(
                                    barcodes.barcodes.first.rawValue!));
                                Navigator.pop(context);
                              },
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hotelRoom.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Card(
                    color: const Color.fromARGB(120, 175, 61, 49),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.asset(hotelRoom[index]['image']),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      hotelRoom[index]['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Container(
                                                  margin: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    children: [
                                                      const Text('QR Code'),
                                                      QrImageView(
                                                          data: hotelRoom[index]
                                                                  ['id']
                                                              .toString()),
                                                    ],
                                                  ),
                                                ));
                                      },
                                      icon: const Icon(Icons.qr_code),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star),
                                        const SizedBox(width: 5.0),
                                        Text(hotelRoom[index]['rating']),
                                      ],
                                    ),
                                    const SizedBox(width: 14),
                                    Row(
                                      children: [
                                        const Icon(Icons.sell),
                                        const SizedBox(width: 5.0),
                                        Text(hotelRoom[index]['price']),
                                        const Text(' / Night'),
                                      ],
                                    ),
                                  ],
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
                                const SizedBox(height: 8.0),
                                Text(
                                  hotelRoom[index]['description'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              Colors.yellow.withOpacity(0.5),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InputHotel(
                                                        id: hotelRoom[index]
                                                            ['id'],
                                                        assets: hotelRoom[index]
                                                            ['image'],
                                                        name: hotelRoom[index]
                                                            ['name'],
                                                        desc: hotelRoom[index]
                                                            ['description'],
                                                        rating: hotelRoom[index]
                                                            ['rating'],
                                                        price: hotelRoom[index]
                                                            ['price'],
                                                        jumlah: hotelRoom[index]
                                                            ['jumlah']),
                                              )).then((_) => refresh());
                                        },
                                        icon: const Icon(Icons.update),
                                        label: const Text('Update'),
                                      ),
                                      const SizedBox(width: 3.0),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              Colors.red.withOpacity(0.5),
                                        ),
                                        onPressed: () async {
                                          await TransactionClient.deletee(
                                              hotelRoom[index]['id']);
                                          refresh();
                                        },
                                        icon: const Icon(Icons.delete),
                                        label: const Text('Delete'),
                                      ),
                                      buttonCreatePDF(context, index),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buttonCreatePDF(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ElevatedButton(
        onPressed: () {
          createPdf(id, context, hotelRoom[index]['name'],
              hotelRoom[index]['price'], hotelRoom[index]['jumlah']);
          setState(() {
            const uuid = Uuid();
            id = uuid.v1();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        child: const Text('Create PDF'),
      ),
    );
  }
}
