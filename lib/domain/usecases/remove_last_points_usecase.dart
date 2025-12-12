import '../repositories/points_repository.dart';

class RemoveLastPointsUseCase {
  final PointsRepository repository;

  RemoveLastPointsUseCase(this.repository);

  Future<void> call() {
    return repository.removeLastPoints();
  }
}
