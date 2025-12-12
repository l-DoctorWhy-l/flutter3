import '../../core/models/point_model.dart';

abstract class PointsRepository {
  Future<List<PointModel>> getPointsHistory();
  Future<void> addPoints(int points);
  Future<void> removeLastPoints();
}
