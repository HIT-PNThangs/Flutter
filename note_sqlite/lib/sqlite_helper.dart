import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static final SQLHelper _sqlHelper = SQLHelper._internal();

  factory SQLHelper() => _sqlHelper;

  SQLHelper._internal();

  static const _databaseName = "note.db";
  static const _databaseTable = "notes";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_databaseTable(
           id integer primary key autoincrement not null,
           title text,
           description text,
           createsAt timestamp not null default current_timestamp
      )
    ''');
  }

  static Future<int> createItem(String? title, String? description) async {
    final database = await _sqlHelper.database;

    final data = {"title": title, "description": description};
    final id = await database.insert(_databaseTable, data, conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllNote() async {
    final database = await _sqlHelper.database;
    return database.query(_databaseTable, orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getNoteById(int id) async {
    final database = await _sqlHelper.database;
    return database.query(_databaseTable, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateNote(int id, String title, String? description) async {
    final database = await _sqlHelper.database;
    final data = {"title": title, "description": description, "createAt": DateTime.now().toString()};

    final result = database.update(_databaseTable, data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteNote(int id) async {
    final database = await _sqlHelper.database;

    try {
      await database.delete(_databaseTable, where: "id = ?", whereArgs: [id]);
    } catch(e) {
      debugPrint("Something went wrong when deleting an item: $e");
    }
  }
}
