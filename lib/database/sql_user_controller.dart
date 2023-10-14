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
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
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
    return await db.update('user', data, where: "id = $id");
  }

  // Delete user :
  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('user', where: "id = $id");
  }
}
