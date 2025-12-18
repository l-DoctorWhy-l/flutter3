import '../repositories/player_repository.dart';

class SavePlayerPasswordUseCase {
  final PlayerRepository repository;

  SavePlayerPasswordUseCase(this.repository);

  Future<void> call(String password) async {
    return repository.savePlayerPassword(password);
  }
}


