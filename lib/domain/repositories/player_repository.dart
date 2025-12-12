import '../../core/models/player_model.dart';

abstract class PlayerRepository {
  Future<PlayerModel> getPlayerProfile();
  Future<void> savePlayerName(String name);
  Future<void> savePlayerNumber(int number);
}
