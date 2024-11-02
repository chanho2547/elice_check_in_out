import 'package:check_in_out_app/models/elicer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  // 데이터베이스 인스턴스 얻기
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // 데이터베이스 초기화
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'elicer.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // 테이블 생성
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE elicers (
        name TEXT PRIMARY KEY,
        className TEXT,
        currentStatus INTEGER,
        lateCount INTEGER,
        checkInTime TEXT,
        checkOutTime TEXT
      )
    ''');
  }

  // 데이터 삽입
  Future<int> insertElicer(Elicer elicer) async {
    Database db = await database;
    return await db.insert(
      'elicers',
      elicer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 모든 데이터 조회
  Future<List<Elicer>> getElicers() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('elicers');

    return List.generate(maps.length, (i) {
      return Elicer.fromMap(maps[i]);
    });
  }

  // 데이터 업데이트
  Future<int> updateElicer(Elicer elicer) async {
    Database db = await database;
    return await db.update(
      'elicers',
      elicer.toMap(),
      where: 'name = ?',
      whereArgs: [elicer.name],
    );
  }

  // 데이터 삭제
  Future<int> deleteElicer(String name) async {
    Database db = await database;
    return await db.delete(
      'elicers',
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}
