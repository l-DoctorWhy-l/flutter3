import '../../domain/models/thesportsdb_domain_models.dart';
import '../../domain/repositories/thesportsdb_repository.dart';
import '../datasources/thesportsdb_api.dart';
import '../models/thesportsdb_mappers.dart';

class TheSportsDbRepositoryImpl implements TheSportsDbRepository {
  final TheSportsDbApi _api;

  TheSportsDbRepositoryImpl(this._api);

  @override
  Future<SportsLeague?> getLeagueDetails(String leagueId) async {
    final response = await _api.getLeagueDetails(leagueId);
    final leagues = response['leagues'];
    if (leagues != null && leagues.isNotEmpty) {
      return leagues.first.toDomain();
    }
    return null;
  }

  @override
  Future<SportsTeam?> getTeamDetails(String teamName) async {
    final response = await _api.getTeamDetails(teamName);
    final teams = response['teams'];
    if (teams != null && teams.isNotEmpty) {
      return teams.first.toDomain();
    }
    return null;
  }

  @override
  Future<List<SportsPlayer>> getTeamPlayers(String teamId) async {
    final response = await _api.getTeamPlayers(teamId);
    final players = response['player'];
    if (players != null) {
      return players.map((dto) => dto.toDomain()).toList();
    }
    return [];
  }

  @override
  Future<List<SportsEvent>> getLastEvents(String teamId) async {
    final response = await _api.getLastEvents(teamId);
    final results = response['results'];
    if (results != null) {
      return results.map((dto) => dto.toDomain()).toList();
    }
    return [];
  }

  @override
  Future<List<SportsEvent>> getNextEvents(String teamId) async {
    final response = await _api.getNextEvents(teamId);
    final events = response['events'];
    if (events != null) {
      return events.map((dto) => dto.toDomain()).toList();
    }
    return [];
  }
}

