import 'dart:convert';
import 'package:http/http.dart';

import 'package:hotel_pbp/entity/user.dart';

class UserClient {
  // Url and Endpoint Emulator :
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/customer';

  // Url and Endpoint Handphone :

  //

  // Mengambil semua data barang dari API :
  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }
      // Mengambil bagian data dari response body :
      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Mengambil data barang dari API berdasarkan Id :
  static Future<User> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      return User.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Membuat data baru :
  static Future<Response> create(User user) async {
    try {
      var response = await post(
        Uri.http(url, endpoint),
        headers: {'Content-Type': 'application/json'},
        body: user.toRawJson(),
      );
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Mengubah data barang berdasarkan Id :
  static Future<Response> update(User user) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: user.toRawJson(),
      );
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      print(response.body);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Menghapus data barang berdasarkan Id :
  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));
      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Update imagePath on specific user :
  static Future<void> updateProfilePicturePath(id, imagePath) async {
    try {
      var response = await put(
        Uri.http(url, '$endpoint/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'profilePicturePath': imagePath}),
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
