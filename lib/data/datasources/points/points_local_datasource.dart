import 'point_dto.dart';

class PointsLocalDataSource {
  final List<PointDto> _history = [];

  Future<List<PointDto>> getPointsHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_history);
  }

  Future<void> addPoints(int points) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _history.add(PointDto(value: points, timestamp: DateTime.now()));
  }

  Future<void> removeLastPoints() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_history.isNotEmpty) {
      _history.removeLast();
    }
  }
}
