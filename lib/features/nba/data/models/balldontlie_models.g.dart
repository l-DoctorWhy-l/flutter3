// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balldontlie_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalldontliePlayerDto _$BalldontliePlayerDtoFromJson(
        Map<String, dynamic> json) =>
    BalldontliePlayerDto(
      id: (json['id'] as num).toInt(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      position: json['position'] as String,
      team: BalldontlieTeamDto.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BalldontliePlayerDtoToJson(
        BalldontliePlayerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'position': instance.position,
      'team': instance.team,
    };

BalldontlieTeamDto _$BalldontlieTeamDtoFromJson(Map<String, dynamic> json) =>
    BalldontlieTeamDto(
      id: (json['id'] as num).toInt(),
      abbreviation: json['abbreviation'] as String,
      city: json['city'] as String,
      conference: json['conference'] as String,
      division: json['division'] as String,
      fullName: json['full_name'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BalldontlieTeamDtoToJson(BalldontlieTeamDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'abbreviation': instance.abbreviation,
      'city': instance.city,
      'conference': instance.conference,
      'division': instance.division,
      'full_name': instance.fullName,
      'name': instance.name,
    };

BalldontlieGameDto _$BalldontlieGameDtoFromJson(Map<String, dynamic> json) =>
    BalldontlieGameDto(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      homeTeam: BalldontlieTeamDto.fromJson(
          json['home_team'] as Map<String, dynamic>),
      visitorTeam: BalldontlieTeamDto.fromJson(
          json['visitor_team'] as Map<String, dynamic>),
      homeTeamScore: (json['home_team_score'] as num).toInt(),
      visitorTeamScore: (json['visitor_team_score'] as num).toInt(),
      season: (json['season'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$BalldontlieGameDtoToJson(BalldontlieGameDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'home_team': instance.homeTeam,
      'visitor_team': instance.visitorTeam,
      'home_team_score': instance.homeTeamScore,
      'visitor_team_score': instance.visitorTeamScore,
      'season': instance.season,
      'status': instance.status,
    };

BalldontlieStatsDto _$BalldontlieStatsDtoFromJson(Map<String, dynamic> json) =>
    BalldontlieStatsDto(
      id: (json['id'] as num).toInt(),
      ast: (json['ast'] as num).toInt(),
      blk: (json['blk'] as num).toInt(),
      pts: (json['pts'] as num).toInt(),
      reb: (json['reb'] as num).toInt(),
      player:
          BalldontliePlayerDto.fromJson(json['player'] as Map<String, dynamic>),
      game: BalldontlieGameDto.fromJson(json['game'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BalldontlieStatsDtoToJson(
        BalldontlieStatsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ast': instance.ast,
      'blk': instance.blk,
      'pts': instance.pts,
      'reb': instance.reb,
      'player': instance.player,
      'game': instance.game,
    };

BalldontlieSeasonAverageDto _$BalldontlieSeasonAverageDtoFromJson(
        Map<String, dynamic> json) =>
    BalldontlieSeasonAverageDto(
      gamesPlayed: (json['games_played'] as num).toInt(),
      season: (json['season'] as num).toInt(),
      pts: (json['pts'] as num).toDouble(),
      ast: (json['ast'] as num).toDouble(),
      reb: (json['reb'] as num).toDouble(),
    );

Map<String, dynamic> _$BalldontlieSeasonAverageDtoToJson(
        BalldontlieSeasonAverageDto instance) =>
    <String, dynamic>{
      'games_played': instance.gamesPlayed,
      'season': instance.season,
      'pts': instance.pts,
      'ast': instance.ast,
      'reb': instance.reb,
    };

BalldontlieResponse<T> _$BalldontlieResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BalldontlieResponse<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      meta: json['meta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BalldontlieResponseToJson<T>(
  BalldontlieResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
      'meta': instance.meta,
    };
