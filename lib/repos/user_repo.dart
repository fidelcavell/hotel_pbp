import 'package:hotel_pbp/database/sql_user_controller.dart';
import 'package:hotel_pbp/models/user_model.dart';

class UserRepo {
  // create user
  static Future<bool> createUser(String username, String email, String password,
      String gender, String noTelp, String origin) async {
    return await SQLUserController.addUser(
                username, email, password, gender, noTelp, origin) >
            0
        ? true
        : false;
  }

  // get all users
  static Future<List<User>> getAllUsers() async {
    final data = await SQLUserController.getAllUsers();
    return List.generate(data.length, (index) => User.fromMap(data[index]));
  }

  // get user by id
  static Future<User> getUserById(int id) async {
    return await SQLUserController.getUserById(id);
  }

  // get user by email
  static Future<Object> getUserByEmail(String email) async {
    return await SQLUserController.getUserByEmail(email);
  }

  // update user
  static Future<bool> updateUser(int id, String username, String email,
      String password, String gender, String noTelp, String origin) async {
    return await SQLUserController.editUser(
                id, username, email, password, gender, noTelp, origin) >
            0
        ? true
        : false;
  }

  // delete user
  static Future<bool> deleteUser(int id) async {
    return await SQLUserController.deleteUser(id) > 0 ? true : false;
  }
}
