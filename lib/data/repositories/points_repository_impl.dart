import '../../core/models/point_model.dart';
import '../../domain/repositories/points_repository.dart';
import '../datasources/points/points_local_datasource.dart';
import '../datasources/points/point_mapper.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsLocalDataSource dataSource;

  PointsRepositoryImpl(this.dataSource);

  @override
  Future<List<PointModel>> getPointsHistory() async {
    final dtos = await dataSource.getPointsHistory();
    return dtos.map((e) => e.toModel()).toList();
  }

  @override
  Future<void> addPoints(int points) async {
    await dataSource.addPoints(points);
  }

  @override
  Future<void> removeLastPoints() async {
    await dataSource.removeLastPoints();
  }
}
