import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtil {

  static Database _database;

  static String _USER_DATABASE_NAME = "user.db";
  static String _FOOD_DATABASE_NAME = "food.db";
  static int _VERSION = 1;

  static init() async{
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + _USER_DATABASE_NAME;
    _database = await openDatabase(path, version: _VERSION, onCreate: (Database db, int version) async {
      // When creating the db, create the table
      //await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)");
    });
  }

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }


  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery("select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  static close() {
    if (_database != null) {
      _database.close();
      _database = null;
    }
  }
}