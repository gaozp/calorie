import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User{
  int _id = 1;
  String name;
  int height;
  int weight;
  bool male;
  int age;
  bool goal;

  int calorie;

  User();

  User.empty();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": name,
      "height": height,
      "weight": weight,
      "male": male== true ? 1:0,
      "age": age,
      "goal": goal==true?1:0,
      "calorie":calorie
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    _id = map["_id"];
    name = map["name"];
    height = map["height"];
    weight = map["weight"];
    male = map["male"]==1;
    goal = map["goal"]==1;
    age = map["age"];
    calorie = map["calorie"];
  }

  @override
  String toString() {
    return 'User{_id: $_id, name: $name, height: $height, weight: $weight, male: $male, age: $age, goal: $goal, calorie: $calorie}';
  }

}

class UserProvider{

  static final UserProvider _instance = new UserProvider.internal();

  UserProvider.internal();

  factory UserProvider() => _instance;

  String db_table = "User";
  String db_path;

  String column_id = "_id";
  String column_name = "name";
  String column_height = "height";
  String column_weight = "weight";
  String column_male = "male";
  String column_goal = "goal";
  String column_age = "age";
  String column_calorie = "calorie";

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
    String path = join(databasesPath, 'user.db');

//    await deleteDatabase(path); // just for testing
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db,int newVersion) async {
    await db.execute(
        "CREATE TABLE User (_id INTEGER PRIMARY KEY, name TEXT,icon TEXT,height INTEGER , weight INTEGER,male INTEGER,age INTEGER ,goal INTEGER,calorie INTEGER)");
  }

  Future<User> insert(User p) async {
    var dbClient = await db;
    p._id = await dbClient.insert(db_table, p.toMap());
    return p;
  }

  Future<List> query() async{
    var dbClient = await db;
    var result = await dbClient.query(db_table,columns: [column_id,column_name,column_height,column_weight,column_male,column_age,column_goal,column_calorie]);
    return result.toList();
  }

  Future<int> update(User u) async {
    var dbClient = await db;
    return await dbClient.update(db_table, u.toMap(),where: "$column_id = ?",whereArgs: [u._id]);
  }

  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient.delete(db_table,where: '$column_id = ?',whereArgs: [id]);
  }


  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}