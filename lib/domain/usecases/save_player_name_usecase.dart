import '../repositories/player_repository.dart';

class SavePlayerNameUseCase {
  final PlayerRepository repository;

  SavePlayerNameUseCase(this.repository);

  Future<void> call(String name) {
    return repository.savePlayerName(name);
  }
}
