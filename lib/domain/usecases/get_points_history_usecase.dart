import '../../core/models/point_model.dart';
import '../repositories/points_repository.dart';

class GetPointsHistoryUseCase {
  final PointsRepository repository;

  GetPointsHistoryUseCase(this.repository);

  Future<List<PointModel>> call() {
    return repository.getPointsHistory();
  }
}
