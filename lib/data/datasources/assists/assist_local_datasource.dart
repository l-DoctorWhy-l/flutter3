import 'package:sqflite/sqflite.dart';
import '../../../core/helpers/database_helper.dart';
import 'assist_dto.dart';

class AssistLocalDataSource {
  Future<List<AssistDto>> getAssists() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('assists', orderBy: 'timestamp DESC');
    return result.map((json) => AssistDto.fromMap(json)).toList();
  }

  Future<void> saveAssist(AssistDto assist) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('assists', assist.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteAssist(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'assists',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
