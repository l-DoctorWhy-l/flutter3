import '../models/balldontlie_domain_models.dart';

abstract class BalldontlieRepository {
  Future<List<NbaPlayer>> getPlayers(int page);
  Future<List<NbaTeam>> getTeams();
  Future<List<NbaGame>> getGames(int page);
  Future<NbaPlayer> getPlayerDetails(int id);
  // Add other methods as needed
}

