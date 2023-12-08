import 'package:flutter/material.dart';
// import 'package:hotel_pbp/components/facilities_box.dart';

class RoomDetail extends StatelessWidget {
  const RoomDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 61, 49),
        title: const Center(
          child: Text('Detail Room'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(15),
              child: Image.asset(
                'assets/hotel1.jpg', // Replace with your image asset,
                fit: BoxFit.cover,
                width: 372,
                height: 249,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Jenis Kamar
                  Center(
                    child: Text(
                      'Standard Room',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),

                  SizedBox(height: 32.0),

                  //Deskripsi kamar
                  Center(
                    child: Text(
                      'Room Description',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),

                  //Isi deskripsi
                  Center(
                    child: Text(
                      'Kamar Deluxe menawarkan pengalaman menginap yang lebih mewah dengan sentuhan tambahan. kamar lebih luas daripada kamar standar dan dilengkapi dengan fasilitas ekstra, seperti area duduk, perlengkapan kamar mandi berkualitas tinggi, dan pemandangan yang lebih menarik. ',
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 22.0),

                  //fasilitas kamar
                  Center(
                    child: Text(
                      'Room Facilities',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    spacing: 8.0,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // FacBox(text: 'wifi'),
                            // FacBox(text: 'AC'),
                            // FacBox(text: 'TV'),
                            // FacBox(text: 'Breakfast'),
                            // FacBox(text: 'Hair Dryer'),
                            // Add other FacBox widgets with their respective text
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.0),

                  //Info hotel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            'Check-in 11 AM',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.calendar_month),
                          Text(
                            'Check-out 12 PM',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.phone),
                          Text(
                            '(123) 555-6789',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.location_city),
                          Text(
                            'Jl. Babarsari No. 44',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                ],
              ),
            ),

            //harga dan button book
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color: const Color.fromARGB(255, 175, 61, 49),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Rp.350.000 /Night',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        // const Spacer(), // Expands to fill the remaining space
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TransactionPage()),
                            // );
                          },
                          child: const Text('Book Now',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
