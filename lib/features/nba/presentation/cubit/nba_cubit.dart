import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/balldontlie_domain_models.dart';
import '../../domain/models/thesportsdb_domain_models.dart';
import '../../domain/repositories/balldontlie_repository.dart';
import '../../domain/repositories/thesportsdb_repository.dart';

abstract class NbaState {}

class NbaInitial extends NbaState {}

class NbaLoading extends NbaState {}

class NbaError extends NbaState {
  final String message;
  NbaError(this.message);
}

// --- Specific Data States ---

class NbaTeamsLoaded extends NbaState {
  final List<NbaTeam> teams;
  NbaTeamsLoaded(this.teams);
}

class NbaPlayersLoaded extends NbaState {
  final List<NbaPlayer> players;
  NbaPlayersLoaded(this.players);
}

class NbaGamesLoaded extends NbaState {
  final List<NbaGame> games;
  NbaGamesLoaded(this.games);
}

class NbaPlayerDetailLoaded extends NbaState {
  final NbaPlayer player;
  NbaPlayerDetailLoaded(this.player);
}

class NbaLeagueLoaded extends NbaState {
  final SportsLeague league;
  final List<String> seasons; // Added
  NbaLeagueLoaded(this.league, this.seasons);
}

class NbaTeamDetailLoaded extends NbaState {
  final SportsTeam team;
  final List<SportsPlayer> roster;
  final List<SportsEvent> lastEvents;
  final List<SportsEvent> nextEvents;

  NbaTeamDetailLoaded({
    required this.team,
    required this.roster,
    required this.lastEvents,
    required this.nextEvents,
  });
}

class NbaCubit extends Cubit<NbaState> {
  final BalldontlieRepository _balldontlieRepository;
  final TheSportsDbRepository _theSportsDbRepository;

  NbaCubit(this._balldontlieRepository, this._theSportsDbRepository)
      : super(NbaInitial());

  // --- Lists ---

  Future<void> fetchTeams() async {
    emit(NbaLoading());
    try {
      final teams = await _balldontlieRepository.getTeams();
      emit(NbaTeamsLoaded(teams));
    } catch (e) {
      emit(NbaError("Error loading teams: $e"));
    }
  }

  Future<void> fetchPlayers() async {
    emit(NbaLoading());
    try {
      final players = await _balldontlieRepository.getPlayers(1);
      emit(NbaPlayersLoaded(players));
    } catch (e) {
      emit(NbaError("Error loading players: $e"));
    }
  }

  Future<void> fetchGames() async {
    emit(NbaLoading());
    try {
      final games = await _balldontlieRepository.getGames(1);
      emit(NbaGamesLoaded(games));
    } catch (e) {
      emit(NbaError("Error loading games: $e"));
    }
  }

  // --- Details ---

  Future<void> fetchPlayerDetails(int id) async {
    emit(NbaLoading());
    try {
      final player = await _balldontlieRepository.getPlayerDetails(id);
      emit(NbaPlayerDetailLoaded(player));
    } catch (e) {
      emit(NbaError("Error loading player details: $e"));
    }
  }

  Future<void> fetchLeagueDetails() async {
    emit(NbaLoading());
    try {
      // 4387 is NBA
      final leagueFuture = _theSportsDbRepository.getLeagueDetails('4387');
      final seasonsFuture = _theSportsDbRepository.getAllSeasons('4387'); // New Request #10

      final results = await Future.wait([leagueFuture, seasonsFuture]);
      final league = results[0] as SportsLeague?;
      final seasons = results[1] as List<String>;

      if (league != null) {
        emit(NbaLeagueLoaded(league, seasons));
      } else {
        emit(NbaError('League not found'));
      }
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchFullTeamData(String teamName) async {
    emit(NbaLoading());
    try {
      final team = await _theSportsDbRepository.getTeamDetails(teamName);
      
      if (team == null) {
        emit(NbaError('Team details not found for $teamName'));
        return;
      }

      final teamId = team.id;
      final results = await Future.wait([
        _theSportsDbRepository.getTeamPlayers(teamId),
        _theSportsDbRepository.getLastEvents(teamId),
        _theSportsDbRepository.getNextEvents(teamId),
      ]);

      emit(NbaTeamDetailLoaded(
        team: team,
        roster: results[0] as List<SportsPlayer>,
        lastEvents: results[1] as List<SportsEvent>,
        nextEvents: results[2] as List<SportsEvent>,
      ));

    } catch (e) {
      emit(NbaError("Error loading team full data: $e"));
    }
  }
}
