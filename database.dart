import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? database;

  Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    String path = join(await getDatabasesPath(), 'matrimonial.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            address TEXT,
            email TEXT,
            mobile TEXT,
            city TEXT,
            gender TEXT,
            dob TEXT,
            hobbies TEXT,
            favourite INTEGER
          )
          ''');
      },
    );

    return database!;
  }

  // INSERT
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await getDatabase();

    int result = await db.insert('users', user);

    return result;
  }

  // GET ALL USERS
  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await getDatabase();

    List<Map<String, dynamic>> users = await db.query('users');

    return users;
  }

  // GET FAVOURITE USERS
  Future<List<Map<String, dynamic>>> getFavouriteUsers() async {
    Database db = await getDatabase();

    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'favourite = ?',
      whereArgs: [1],
    );

    return users;
  }

  // UPDATE USER
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    Database db = await getDatabase();

    int result = await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  // UPDATE FAVOURITE
  Future<int> updateFavourite(int id, int favourite) async {
    Database db = await getDatabase();

    int result = await db.update(
      'users',
      {'favourite': favourite},
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  // DELETE USER
  Future<int> deleteUser(int id) async {
    Database db = await getDatabase();

    int result = await db.delete('users', where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
