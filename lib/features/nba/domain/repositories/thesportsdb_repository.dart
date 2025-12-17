import '../models/thesportsdb_domain_models.dart';

abstract class TheSportsDbRepository {
  Future<SportsLeague?> getLeagueDetails(String leagueId);
  Future<SportsTeam?> getTeamDetails(String teamName);
  Future<List<SportsPlayer>> getTeamPlayers(String teamId);
  Future<List<SportsEvent>> getLastEvents(String teamId);
  Future<List<SportsEvent>> getNextEvents(String teamId);
}

