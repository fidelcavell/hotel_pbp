class User {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? gender;
  final String? nomorTelepon;
  final String? origin;
  final String? profilePicture;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.gender,
      this.nomorTelepon,
      this.origin,
      this.profilePicture});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as int?,
        username: map['username'] as String?,
        email: map['email'] as String?,
        password: map['password'] as String?,
        gender: map['gender'] as String?,
        nomorTelepon: map['noTelp'] as String?,
        origin: map['origin'] as String?,
        profilePicture: map['profilePicture'] as String?);
  }
}
