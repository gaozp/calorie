import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Food {
  int _id;
  String icon;
  String name;
  double protein;
  double fat;
  double carbohydrate;


  Food(this.name, this.protein, this.fat,
      this.carbohydrate);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": name,
      "icon":icon,
      "protein": protein,
      "fat": fat,
      "carbohydrate": carbohydrate
    };
    return map;
  }

  Food.fromMap(Map<String,dynamic> map){
    _id=map["_id"];
    name= map["name"];
    icon=map["icon"];
    protein =map["protein"];
    fat = map["fat"];
    carbohydrate = map["carbohydrate"];
  }

  @override
  String toString() {
    return 'Food{_id: $_id, icon: $icon, name: $name, protein: $protein, fat: $fat, carbohydrate: $carbohydrate}';
  }


}

class FoodProvider{
  static final FoodProvider _instance = new FoodProvider.internal();

  FoodProvider.internal();

  factory FoodProvider() => _instance;

  String db_table ="food";
  String db_path;

  String column_id="_id";
  String column_name="name";
  String column_protein = "protein";
  String column_fat="fat";
  String column_carbohydrate = "carbohydrate";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'food.db');

//    await deleteDatabase(path); // just for testing
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db,int newVersion) async {
    await db.execute(
        "CREATE TABLE Food (_id INTEGER PRIMARY KEY, name TEXT,icon TEXT,male INTEGER,protein REAL, fat REAL,carbohydrate REAL)");
  }

  Future<Food> insert(Food f) async {
    var dbClient = await db;
    f._id = await dbClient.insert("Food", f.toMap());
    return f;
  }

  Future<List> query() async{
    var dbClient = await db;
    var result = await dbClient.query(db_table,columns: [column_id,column_name,column_protein,column_fat,column_carbohydrate]);
    return result.toList();
  }
}