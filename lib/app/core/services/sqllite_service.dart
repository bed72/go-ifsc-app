import 'dart:io';
import 'package:go_ifsc/app/core/models/message_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBService {
  DBService._();

  static final DBService db = DBService._();

  Database _database;

  final String dataBase = "go.db";
  final String tableNotification = "notifications";
  final String createTableNotification =
      "CREATE TABLE notifications(id INTEGER PRIMARY KEY, title TEXT, body TEXT, message TEXT)";

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

  Future create(MessageModel model) async {
    try {
      final Database _db = await database;
      await _db.insert(
        this.tableNotification,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('\n\nError no create: \n${e.toString()} \n\n');
      return;
    }
  }

  Future index(String title) async {
    try {
      final Database _db = await database;
      var response = await _db.query(
        this.tableNotification,
        where: 'title LIKE ?',
        whereArgs: [title],
      );
      // var response = await _db
      //     .rawQuery('SELECT * FROM notifications WHERE title LIKE "%$title"');
      List<MessageModel> list = response.isNotEmpty
          ? response.map((e) => MessageModel.fromMap(e)).toList()
          : [];
      return list;
    } catch (e) {
      print('\n\nError no index: \n${e.toString()} \n\n');
      return;
    }
  }

  Future show() async {
    try {
      final Database _db = await database;
      var response = await _db.query(
        this.tableNotification,
      );
      List<MessageModel> list = response.isNotEmpty
          ? response.map((e) => MessageModel.fromMap(e)).toList()
          : [];

      print('\n SHOW $response \n');
      return list.reversed.toList();
    } catch (e) {
      print('\n\nError no show: \n${e.toString()} \n\n');
      return;
    }
  }

  Future update(MessageModel model) async {
    try {
      final Database _db = await database;
      await _db.update(
        this.tableNotification,
        model.toMap(),
        where: "id = ?",
        whereArgs: [model.id],
      );
    } catch (e) {
      print('\n\nError no update: \n${e.toString()} \n\n');
      return;
    }
  }

  Future delete(int id) async {
    try {
      final Database _db = await database;
      await _db.delete(
        this.tableNotification,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print('\n\nError no delete: \n${e.toString()} \n\n');
      return;
    }
  }
}
