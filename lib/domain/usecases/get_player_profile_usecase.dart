import '../../core/models/player_model.dart';
import '../repositories/player_repository.dart';

class GetPlayerProfileUseCase {
  final PlayerRepository repository;

  GetPlayerProfileUseCase(this.repository);

  Future<PlayerModel> call() {
    return repository.getPlayerProfile();
  }
}
