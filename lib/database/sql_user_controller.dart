import 'package:hotel_pbp/models/user_model.dart';
import './sql_helper.dart';

class SQLUserController {
  // Create or add User :
  static Future<int> addUser(String username, String email, String password,
      String gender, String noTelp, String origin) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'gender': gender,
      'noTelp': noTelp,
      'origin': origin,
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
  static Future<Object> getUserByEmail(String email) async {
    final db = await SQLHelper.db();
    final data = await db.query('user', where: "email = ?", whereArgs: [email]);
    return data.isNotEmpty ? User.fromMap(data.first) : Null;
  }

  // Update user :
  static Future<int> editUser(int id, String username, String email,
      String password, String gender, String noTelp, String origin) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'gender': gender,
      'noTelp': noTelp,
      'origin': origin,
    };
    return await db.update('user', data, where: "id = ?", whereArgs: [id]);
  }

  // Delete user :
  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('user', where: "id = $id");
  }

  // Utils for Login(Return User ID if success, -1 if failed) :
  static Future<int> login(String username, String password) async {
    final db = await SQLHelper.db();
    final data = await db.query('user',
        where: "username = ? AND password = ?",
        whereArgs: [username, password]);
    return data.isNotEmpty ? User.fromMap(data.first).id ?? -1 : -1;
  }

  // Utils for Update Profile Picture By ID (Return 1 if success, 0 if failed) :
  static Future<int> updateProfilePictureById(
      int id, String profilePicture) async {
    final db = await SQLHelper.db();
    final data = {'profilePicture': profilePicture};
    return await db.update('user', data, where: "id = ?", whereArgs: [id]);
  }
}