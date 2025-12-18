import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('stats.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path, 
      version: 2, 
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE teams ( 
          id INTEGER PRIMARY KEY, 
          full_name TEXT NOT NULL,
          city TEXT NOT NULL,
          conference TEXT NOT NULL,
          division TEXT NOT NULL
        )
      ''');
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE assists ( 
  id $textType PRIMARY KEY, 
  timestamp $integerType
  )
''');

    await db.execute('''
CREATE TABLE points ( 
  id $idType, 
  value $integerType,
  timestamp $integerType
  )
''');

    await db.execute('''
CREATE TABLE injuries ( 
  id $idType, 
  is_injured $boolType,
  timestamp $integerType
  )
''');

    await db.execute('''
CREATE TABLE teams ( 
  id INTEGER PRIMARY KEY, 
  full_name TEXT NOT NULL,
  city TEXT NOT NULL,
  conference TEXT NOT NULL,
  division TEXT NOT NULL
  )
''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}


