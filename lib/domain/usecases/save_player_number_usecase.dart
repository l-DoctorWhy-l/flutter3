import '../repositories/player_repository.dart';

class SavePlayerNumberUseCase {
  final PlayerRepository repository;

  SavePlayerNumberUseCase(this.repository);

  Future<void> call(int number) {
    return repository.savePlayerNumber(number);
  }
}
