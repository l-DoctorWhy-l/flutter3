import '../../../core/helpers/database_helper.dart';
import 'injury_dto.dart';

class InjuryLocalDataSource {
  Future<InjuryDto> getInjuryStatus() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('injuries', orderBy: 'timestamp DESC', limit: 1);
    
    if (result.isNotEmpty) {
      return InjuryDto.fromMap(result.first);
    } else {
      return InjuryDto(isInjured: false, timestamp: DateTime.now());
    }
  }

  Future<List<InjuryDto>> getInjuryHistory() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('injuries', orderBy: 'timestamp DESC');
    return result.map((json) => InjuryDto.fromMap(json)).toList();
  }

  Future<void> setInjuryStatus(bool isInjured) async {
    final db = await DatabaseHelper.instance.database;
    final injuryDto = InjuryDto(isInjured: isInjured, timestamp: DateTime.now());
    await db.insert('injuries', injuryDto.toMap());
  }
}
