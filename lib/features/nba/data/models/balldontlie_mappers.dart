import '../models/balldontlie_models.dart';
import '../../domain/models/balldontlie_domain_models.dart';

extension BalldontliePlayerDtoMapper on BalldontliePlayerDto {
  NbaPlayer toDomain() {
    return NbaPlayer(
      id: id,
      firstName: firstName,
      lastName: lastName,
      position: position,
      teamName: team.fullName,
    );
  }
}

extension BalldontlieTeamDtoMapper on BalldontlieTeamDto {
  NbaTeam toDomain() {
    return NbaTeam(
      id: id,
      fullName: fullName,
      city: city,
      conference: conference,
    );
  }
}

extension BalldontlieGameDtoMapper on BalldontlieGameDto {
  NbaGame toDomain() {
    return NbaGame(
      id: id,
      date: date,
      homeTeam: homeTeam.fullName,
      visitorTeam: visitorTeam.fullName,
      homeScore: homeTeamScore,
      visitorScore: visitorTeamScore,
      status: status,
    );
  }
}

extension BalldontlieStatsDtoMapper on BalldontlieStatsDto {
  NbaStats toDomain() {
    return NbaStats(
      points: pts,
      assists: ast,
      rebounds: reb,
      blocks: blk,
      playerName: '${player.firstName} ${player.lastName}',
    );
  }
}

extension BalldontlieSeasonAverageDtoMapper on BalldontlieSeasonAverageDto {
  NbaSeasonStats toDomain() {
    return NbaSeasonStats(
      season: season,
      pts: pts,
      ast: ast,
      reb: reb,
      gamesPlayed: gamesPlayed,
    );
  }
}
