import '../../../core/helpers/database_helper.dart';
import 'point_dto.dart';

class PointsLocalDataSource {
  Future<List<PointDto>> getPointsHistory() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('points', orderBy: 'timestamp ASC');
    return result.map((json) => PointDto.fromMap(json)).toList();
  }

  Future<void> addPoints(int points) async {
    final db = await DatabaseHelper.instance.database;
    final pointDto = PointDto(value: points, timestamp: DateTime.now());
    await db.insert('points', pointDto.toMap());
  }

  Future<void> removeLastPoints() async {
    final db = await DatabaseHelper.instance.database;
    final lastRecord = await db.query('points', orderBy: 'id DESC', limit: 1);
    
    if (lastRecord.isNotEmpty) {
      final id = lastRecord.first['id'];
      await db.delete('points', where: 'id = ?', whereArgs: [id]);
    }
  }
}
