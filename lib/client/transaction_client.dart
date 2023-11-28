import 'package:http/http.dart';
import 'dart:convert';

class TransactionClient {
  // Url dan Endpoint Emulator :
  static const String url = '10.0.2.2:8000'; 
  static const String endpoint = '/api/hotel';

  // Url dan Endpoint Handphone :

  //

  static Future<List<Map<String, dynamic>>> fetchAll() async {
    try {
      var response = await get(
          Uri.http(
            url,
            endpoint,
          ),
          headers: {'Accept': 'application/json'});

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      Iterable list = json.decode(response.body);

      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<int> create(String name, String description, String price,
      String rating, String jumlah, String image) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {'Accept': 'application/json'},
        body: {
          'name': name,
          'description': description,
          'price': price,
          'rating': rating,
          'jumlah': jumlah,
          'image': image,
        },
      );

      return response.statusCode;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<int> update(int id, String name, String description,
      String price, String rating, String jumlah, String image) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/$id'),
        headers: {'Accept': 'application/json'},
        body: {
          'name': name,
          'description': description,
          'price': price,
          'rating': rating,
          'jumlah': jumlah,
          'image': image,
        },
      );

      return response.statusCode;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<int> deletee(int id) async {
    try {
      var response = await delete(
        Uri.http(url, '$endpoint/$id'),
        headers: {'Accept': 'application/json'},
      );

      return response.statusCode;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
