import 'dart:convert';

class User {
  int id, nomorTelepon;
  String username, email, password, gender, origin;
  String? profilePicture;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.gender,
      required this.nomorTelepon,
      required this.origin,
      this.profilePicture});

  // Untuk membuat objek barang dari data json yang diterima dari API :
  factory User.fromRawJson(String str) => User.fromJson(jsonDecode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        gender: json['gender'],
        nomorTelepon: json['nomorTelepon'],
        origin: json['origin'],
        profilePicture: json['profilePicture'],
      );

  // Untuk membuat data json dari objek barang yang dikirim ke API :
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'gender': gender,
        'nomorTelepon': nomorTelepon,
        'origin': origin,
        'profilePicture': profilePicture,
      };
}
