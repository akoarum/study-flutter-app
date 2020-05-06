import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:study_flutter_app/src/models/todo.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;
  static final _tableName = "Todos";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory _documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(_documentsDirectory.path, 'TodoDB.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    return await db.execute(
      "CREATE TABLE Todos ("
      "id TEXT PRIMARY KEY,"
      "text TEXT,"
      "isCompleted TEXT,"
      "createdAt TEXT"
      ")"
    );
  }

  createTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(_tableName, todo.toMap());
    return res;
  }

  getAllTodos() async {
    final db = await database;
    var res = await db.query(_tableName);

    List<Todo> todos = res.isNotEmpty
      ? res.map((c) => Todo.fromMap(c)).toList()
      : [];

    return todos;
  }

  updateTodo(Todo todo) async {
    final db = await database;
    var res = await db.update(
      _tableName,
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id]
    );
    return res;
  }

  deleteTodo(String id) async {
    final db = await database;
    var res = await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id]
    );
    return res;
  }
}
