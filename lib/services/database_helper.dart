import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/item_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE items (
      id $idType,
      name $textType
    )
    ''');
  }

  Future<List<Item>> getItems() async {
    final db = await instance.database;
    final result = await db.query('items');

    return result.map((json) => Item.fromMap(json)).toList();
  }

  Future<int> insertItem(Item item) async {
    final db = await instance.database;
    return await db.insert('items', item.toMap());
  }

  Future<int> updateItem(Item item) async {
    final db = await instance.database;
    return await db
        .update('items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<int> deleteItem(int id) async {
    final db = await instance.database;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
