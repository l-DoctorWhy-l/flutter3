import '../models/balldontlie_domain_models.dart';

abstract class BalldontlieRepository {
  Future<List<NbaPlayer>> getPlayers(int page, {String? search});
  Future<List<NbaTeam>> getTeams();
  Future<List<NbaGame>> getGames(int page);
  Future<NbaPlayer> getPlayerDetails(int id);
  Future<NbaTeam> getTeam(int id);
}
