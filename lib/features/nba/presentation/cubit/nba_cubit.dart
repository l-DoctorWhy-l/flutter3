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

class NbaDataLoaded extends NbaState {
  final String title;
  final String data;
  NbaDataLoaded(this.title, this.data);
}

class NbaCubit extends Cubit<NbaState> {
  final BalldontlieRepository _balldontlieRepository;
  final TheSportsDbRepository _theSportsDbRepository;

  NbaCubit(this._balldontlieRepository, this._theSportsDbRepository)
      : super(NbaInitial());

  // Balldontlie Methods
  Future<void> fetchPlayers() async {
    emit(NbaLoading());
    try {
      final players = await _balldontlieRepository.getPlayers(1);
      final data = players
          .map((e) =>
              '${e.firstName} ${e.lastName} (${e.position}) - ${e.teamName}')
          .join('\n');
      emit(NbaDataLoaded('NBA Players (Balldontlie)', data));
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchTeams() async {
    emit(NbaLoading());
    try {
      final teams = await _balldontlieRepository.getTeams();
      final data = teams
          .map((e) => '${e.fullName} (${e.city}) - ${e.conference}')
          .join('\n');
      emit(NbaDataLoaded('NBA Teams (Balldontlie)', data));
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchGames() async {
    emit(NbaLoading());
    try {
      final games = await _balldontlieRepository.getGames(1);
      final data = games
          .map((e) =>
              '${e.date}: ${e.homeTeam} vs ${e.visitorTeam} (${e.homeScore}-${e.visitorScore})')
          .join('\n');
      emit(NbaDataLoaded('Recent Games (Balldontlie)', data));
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchPlayerDetails() async {
    emit(NbaLoading());
    try {
      final player = await _balldontlieRepository.getPlayerDetails(237);
      final data = '${player.firstName} ${player.lastName}\nPosition: ${player.position}\nTeam: ${player.teamName}';
      emit(NbaDataLoaded('Player Details (Balldontlie)', data));
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchSeasonAverages() async {
      emit(NbaLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(NbaDataLoaded('Season Averages (Balldontlie)', "Feature requires specific player IDs. Shown as demo placeholder."));
  }


  // TheSportsDB Methods
  Future<void> fetchLeagueDetails() async {
    emit(NbaLoading());
    try {
      final league = await _theSportsDbRepository.getLeagueDetails('4387');
      if (league != null) {
        emit(NbaDataLoaded('League Details (TheSportsDB)',
            '${league.name} (${league.sport})\n${league.alternateName}'));
      } else {
        emit(NbaError('League not found'));
      }
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchTeamDetails() async {
    emit(NbaLoading());
    try {
      final team = await _theSportsDbRepository.getTeamDetails('Golden State Warriors');
      if (team != null) {
        emit(NbaDataLoaded('Team Details (TheSportsDB)',
            '${team.name} (${team.shortName})\nStadium: ${team.stadium}\n\n${team.description.substring(0, 200)}...'));
      } else {
        emit(NbaError('Team not found'));
      }
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchTeamPlayers() async {
    emit(NbaLoading());
    try {
      final players = await _theSportsDbRepository.getTeamPlayers('134865');
      final data = players
          .map((e) => '${e.name} - ${e.position} (${e.height}, ${e.weight})')
          .join('\n');
      emit(NbaDataLoaded('Team Players (TheSportsDB)', data));
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchLastEvents() async {
    emit(NbaLoading());
    try {
      final events = await _theSportsDbRepository.getLastEvents('134865');
      final data = events
          .map((e) =>
              '${e.date}: ${e.eventName} (${e.homeScore}-${e.awayScore})')
          .join('\n');
      emit(NbaDataLoaded('Last Events (TheSportsDB)', data));
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }

  Future<void> fetchNextEvents() async {
    emit(NbaLoading());
    try {
      final events = await _theSportsDbRepository.getNextEvents('134865');
      final data = events
          .map((e) => '${e.date} ${e.time}: ${e.eventName}')
          .join('\n');
      emit(NbaDataLoaded('Next Events (TheSportsDB)', data));
    } catch (e) {
      emit(NbaError(e.toString()));
    }
  }
}

