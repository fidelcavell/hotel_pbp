import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // Create tables :
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        username TEXT,
        email TEXT UNIQUE,
        password TEXT,
        gender TEXT,
        noTelp TEXT,
        origin TEXT,
        profilePicture TEXT DEFAULT NULL
      )
    """);

    await database.execute("""
      CREATE TABLE hotel(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        image TEXT, 
        name TEXT,
        description TEXT,
        rating TEXT,
        price TEXT,
        jumlah TEXT
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'user.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
}
