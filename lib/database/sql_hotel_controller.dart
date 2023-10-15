import './sql_helper.dart';

class SQLHotelController {
  // Create or add hotel :
  static Future<int> addHotel(String image, String name, String desc,
      String rating, String price, String jumlah) async {
    final db = await SQLHelper.db();
    final data = {
      'image': image,
      'name': name,
      'description': desc,
      'rating': rating,
      'price': price,
      'jumlah': jumlah,
    };
    return await db.insert('hotel', data); //error
  }

  // Read or display hotel :
  static Future<List<Map<String, dynamic>>> getHotel() async {
    final db = await SQLHelper.db();
    return db.query('hotel');
  }

  // Update hotel :
  static Future<int> editHotel(int id, String image, String name, String desc,
      String rating, String price, String jumlah) async {
    final db = await SQLHelper.db();
    final data = {
      'image': image,
      'name': name,
      'description': desc,
      'rating': rating,
      'price': price,
      'jumlah': jumlah,
    };
    return await db.update('hotel', data, where: "id = $id");
  }

  // Delete hotel :
  static Future<int> deleteHotel(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('hotel', where: "id = $id");
  }
}
