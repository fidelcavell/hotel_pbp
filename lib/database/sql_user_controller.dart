import 'package:hotel_pbp/models/user_model.dart';

import './sql_helper.dart';

class SQLUserController {
  // Create or add User :
  static Future<int> addUser(String username, String email, String password,
      String gender, String noTelp) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'gender': gender,
      'noTelp': noTelp
    };
    return await db.insert('user', data);
  }

  // Read or display user :
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await SQLHelper.db();
    print(await db.query('user'));
    return db.query('user');
  }

  // Read or display user (one) by id :
  static Future<User> getUserById(int id) async {
    final db = await SQLHelper.db();
    final data = await db.query('user', where: "id = ?", whereArgs: [id]);
    return User.fromMap(data.first);
  }

  // Read or display user (one) by email :
  static Future<User> getUserByEmail(String email) async {
    final db = await SQLHelper.db();
    final data = await db.query('user', where: "email = ?", whereArgs: [email]);
    return User.fromMap(data.first);
  }

  // Update user :
  static Future<int> editUser(int id, String username, String email,
      String password, String gender, String noTelp) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'gender': gender,
      'noTelp': noTelp
    };
    return await db.update('user', data, where: "id = ?", whereArgs: [id]);
  }

  // Delete user :
  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('user', where: "id = $id");
  }
}
