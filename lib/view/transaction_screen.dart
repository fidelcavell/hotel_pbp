import 'package:flutter/material.dart';
import 'package:hotel_pbp/view/option_type_room.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:hotel_pbp/pdf/pdf_view.dart';
import '../event/input_hotel.dart';
import 'package:hotel_pbp/client/transaction_client.dart';
import 'package:hotel_pbp/components/loading_indicator.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Map<String, dynamic>> hotelRoom = [];
  bool isFavorite = false;
  String id = const Uuid().v1();
  bool _loading = false;

  //* To show Loading Screen indicator :
  void _onLoading() {
    setState(() {
      _loading = true;
      Future.delayed(const Duration(seconds: 4), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  //* To reset current temporary list with new data :
  void refresh() async {
    final data = await TransactionClient.fetchAll();
    setState(() {
      hotelRoom = data;
    });
  }

  //* Put all hotel's id to temporary list :
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
    _onLoading();
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 96, 81),
        foregroundColor: Colors.white,
        title: const Text('Transaction'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OptionTypeRoom(),
                  )).then((_) => refresh());
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add New Hotel Room',
          ),
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
                          getHotelById(
                              int.parse(barcodes.barcodes.first.rawValue!));
                          Navigator.pop(context);
                        },
                      ),
                    );
                  });
            },
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'QR Code',
          ),
        ],
      ),
      body: _loading
          ? const LoadingIndicator()
          : hotelRoom.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 100),
                      child: const Text(
                        'Tidak ada pesanan kamar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: hotelRoom.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      child: Card(
                        color: const Color.fromARGB(255, 230, 96, 81),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 165,
                                child: Image.asset(
                                  hotelRoom[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            hotelRoom[index]['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
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
                                                            .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.qr_code,
                                              color: Colors.white,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              createPdf(
                                                id,
                                                context,
                                                hotelRoom[index]['name'],
                                                hotelRoom[index]['price'],
                                                hotelRoom[index]['jumlah'],
                                              );
                                              setState(() {
                                                const uuid = Uuid();
                                                id = uuid.v1();
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.picture_as_pdf_sharp,
                                              color: Colors.white,
                                            ),
                                            tooltip: 'Create PDF',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            hotelRoom[index]['rating'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 20.0),
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
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.attach_money_rounded,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            hotelRoom[index]['price'],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 24.0),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.bed,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            hotelRoom[index]['jumlah'],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 5.0),
                                          const Text(
                                            'Room',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        ElevatedButton.icon(
                                          key: const Key('editButton'),
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 223, 209, 86),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      InputHotel(
                                                          id: hotelRoom[index]
                                                              ['id'],
                                                          assets:
                                                              hotelRoom[index]
                                                                  ['image'],
                                                          name: hotelRoom[index]
                                                              ['name'],
                                                          desc: hotelRoom[index]
                                                              ['description'],
                                                          rating:
                                                              hotelRoom[index]
                                                                  ['rating'],
                                                          price:
                                                              hotelRoom[index]
                                                                  ['price'],
                                                          jumlah:
                                                              hotelRoom[index]
                                                                  ['jumlah']),
                                                )).then((_) => refresh());
                                          },
                                          icon: const Icon(Icons.update),
                                          label: const Text(
                                            'Update',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        const SizedBox(width: 5.0),
                                        ElevatedButton.icon(
                                          key: const Key('deleteButton'),
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
                                          label: const Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
