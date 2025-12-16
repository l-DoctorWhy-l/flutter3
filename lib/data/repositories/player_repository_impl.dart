import '../../core/models/player_model.dart';
import '../../domain/repositories/player_repository.dart';
import '../datasources/player/player_local_datasource.dart';
import '../datasources/player/player_mapper.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerLocalDataSource dataSource;

  PlayerRepositoryImpl(this.dataSource);

  @override
  Future<PlayerModel> getPlayerProfile() async {
    final dto = await dataSource.getPlayerProfile();
    return dto.toModel();
  }

  @override
  Future<void> savePlayerName(String name) async {
    await dataSource.savePlayerName(name);
  }

  @override
  Future<void> savePlayerPassword(String password) async {
    await dataSource.savePlayerPassword(password);
  }

  @override
  Future<void> savePlayerNumber(int number) async {
    await dataSource.savePlayerNumber(number);
  }
}
