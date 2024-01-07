
import 'package:managementteam/model/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum SQLTable { person }

enum SQLDataType { text, integer }

class SQLLiteManager {
  static final share = SQLLiteManager();

  Future<Database>? database;
  User? user;

  Future createDatabase() async {
    database = openDatabase(
      join(
        await getDatabasesPath(),
        'team_management.db',
      ),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE person(id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER ,name TEXT,latin TEXT,sex TEXT,phone TEXT,address TEXT,job_title TEXT,status TEXT,current_address TEXT,comment TEXT,birth_day DATE)');
      },
      version: 1,
    );
  }

  Future<void> insertColumn(
      SQLTable table, String column, SQLDataType type) async {
    var db = await database;

    var objects = await share.objects(table);
    var keys = objects?.first.keys ?? [];
    if (!keys.contains(column)) {
      await db?.execute(
        "ALTER TABLE ${table.name} ADD COLUMN $column ${type.name};",
      );
    }
  }

  Future<void> delete(SQLTable table, int id) async {
    var db = await database;
    await db?.delete(
      table.name,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insert(SQLTable table, Map<String, dynamic> json) async {
    database?.then(
      (value) => value.insert(
        table.name,
        json,
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  Future<void> update(SQLTable table, int id, Map<String, dynamic> json) async {
    var db = await database;
    await db?.update(
      table.name,
      json,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>?> objects(SQLTable table) async {
    final objects = database?.then(
      (value) => value.query(
        table.name,
        where: 'user_id = ?',
        whereArgs: [user?.id ?? 0],
      ),
    );
    return objects;
  }

  Future<void> remove(SQLTable table, int objectId) async {
    final db = await database;
    await db?.delete(
      table.name,
      where: 'id = ?',
      whereArgs: [objectId],
    );
  }
}
