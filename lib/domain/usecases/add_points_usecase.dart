import '../repositories/points_repository.dart';

class AddPointsUseCase {
  final PointsRepository repository;

  AddPointsUseCase(this.repository);

  Future<void> call(int points) {
    return repository.addPoints(points);
  }
}
