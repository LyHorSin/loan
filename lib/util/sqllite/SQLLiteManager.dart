import 'package:managementteam/model/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum SQLTable { person }

enum SQLDataType { text, integer }

class SQLLiteManager {
  static final share = SQLLiteManager();

  int dbVersion = 1;

  Future<Database>? database;
  User? user;

  List<String> columns = [
    'id INTEGER PRIMARY KEY AUTOINCREMENT',
    'user_id INTEGER',
    'branch TEXT',
    'name TEXT',
    'latin TEXT',
    'sex TEXT',
    'phone TEXT',
    'address TEXT',
    'job_title TEXT',
    'status TEXT',
    'current_address TEXT',
    'comment TEXT',
    'birth_day DATE',
    'address_village TEXT',
    'address_district TEXT',
    'address_commune TEXT',
    'address_province TEXT',
    'current_village TEXT',
    'current_district TEXT',
    'current_commune TEXT',
    'current_province TEXT',
  ];

  Future createDatabase() async {
    database = openDatabase(
      join(
        await getDatabasesPath(),
        'team_management.db',
      ),
      onCreate: (db, version) {
        String joinColumns = columns.join(",");
        db.execute('CREATE TABLE person($joinColumns)');
      },
      version: dbVersion,
      onUpgrade: (db, oldVersion, newVersion) {
        _onUpgrade(db, oldVersion, newVersion);
      },
    );
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();

    List<String> newColumns = [
      'branch TEXT',
      'address_village TEXT',
      'address_district TEXT',
      'address_commune TEXT',
      'address_province TEXT',
      'current_village TEXT',
      'current_district TEXT',
      'current_commune TEXT',
      'current_province TEXT',
    ];

    for (String column in newColumns) {
      batch.execute('ALTER TABLE person ADD COLUMN $column');
    }
    batch.commit(noResult: true); // ignore the result for better performance
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
