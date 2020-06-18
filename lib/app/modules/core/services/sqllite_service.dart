import 'dart:io';

import 'package:go_ifsc/app/modules/core/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  DBService._();

  static final DBService db = DBService._();

  Database _database;

  final String dataBase = "go.db";
  final String tableNotification = "notifications";
  final String createTableNotification =
      "CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT)";

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}${this.dataBase}';
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(this.createTableNotification);
      },
    );
  }

  Future create(UserModel model) async {
    try {
      final Database _db = await database;
      await _db.insert(
        this.tableNotification,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('\n\nError no create: \n$e \n\n');
      return;
    }
  }

  Future index(String name) async {
    try {
      final Database _db = await database;
      await _db.query(
        this.tableNotification,
        where: "name = ?",
        whereArgs: [name],
      );
    } catch (e) {
      print('\n\nError no create: \n$e \n\n');
      return;
    }
  }

  Future update(UserModel model) async {
    try {
      final Database _db = await database;
      await _db.update(
        this.tableNotification,
        model.toMap(),
        where: "name = ?",
        whereArgs: [model.name],
      );
    } catch (e) {
      print('\n\nError no update: \n$e \n\n');
      return;
    }
  }

  Future delete(UserModel model) async {
    try {
      final Database _db = await database;
      await _db.delete(
        this.tableNotification,
        where: "name = ?",
        whereArgs: [model.name],
      );
    } catch (e) {
      print('\n\nError no delete: \n$e \n\n');
      return;
    }
  }
}
