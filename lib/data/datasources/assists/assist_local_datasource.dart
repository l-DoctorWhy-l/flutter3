import 'assist_dto.dart';

class AssistLocalDataSource {
  final List<AssistDto> _assists = [];

  Future<List<AssistDto>> getAssists() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_assists);
  }

  Future<void> saveAssist(AssistDto assist) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _assists.add(assist);
  }

  Future<void> deleteAssist(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _assists.removeWhere((element) => element.id == id);
  }
}
