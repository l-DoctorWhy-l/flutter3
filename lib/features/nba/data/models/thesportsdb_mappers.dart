import '../models/thesportsdb_models.dart';
import '../../domain/models/thesportsdb_domain_models.dart';

extension TheSportsDbLeagueDtoMapper on TheSportsDbLeagueDto {
  SportsLeague toDomain() {
    return SportsLeague(
      id: idLeague ?? '',
      name: strLeague ?? 'Unknown League',
      sport: strSport ?? 'Unknown Sport',
      alternateName: strLeagueAlternate ?? '',
    );
  }
}

extension TheSportsDbTeamDtoMapper on TheSportsDbTeamDto {
  SportsTeam toDomain() {
    return SportsTeam(
      id: idTeam ?? '',
      name: strTeam ?? 'Unknown Team',
      shortName: strTeamShort ?? '',
      formedYear: intFormedYear ?? '',
      stadium: strStadium ?? '',
      description: strDescriptionEN ?? '',
    );
  }
}

extension TheSportsDbPlayerDtoMapper on TheSportsDbPlayerDto {
  SportsPlayer toDomain() {
    return SportsPlayer(
      id: idPlayer ?? '',
      name: strPlayer ?? 'Unknown Player',
      teamName: strTeam ?? '',
      position: strPosition ?? '',
      height: strHeight ?? '',
      weight: strWeight ?? '',
    );
  }
}

extension TheSportsDbEventDtoMapper on TheSportsDbEventDto {
  SportsEvent toDomain() {
    return SportsEvent(
      id: idEvent ?? '',
      eventName: strEvent ?? 'Unknown Event',
      homeTeam: strHomeTeam ?? 'Unknown Home Team',
      awayTeam: strAwayTeam ?? 'Unknown Away Team',
      homeScore: intHomeScore ?? '-',
      awayScore: intAwayScore ?? '-',
      date: dateEvent ?? '',
      time: strTime ?? '',
    );
  }
}
