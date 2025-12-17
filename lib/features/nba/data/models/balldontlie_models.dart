import 'package:json_annotation/json_annotation.dart';

part 'balldontlie_models.g.dart';

@JsonSerializable()
class BalldontliePlayerDto {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String position;
  final BalldontlieTeamDto team;

  BalldontliePlayerDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.team,
  });

  factory BalldontliePlayerDto.fromJson(Map<String, dynamic> json) =>
      _$BalldontliePlayerDtoFromJson(json);
}

@JsonSerializable()
class BalldontlieTeamDto {
  final int id;
  final String abbreviation;
  final String city;
  final String conference;
  final String division;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String name;

  BalldontlieTeamDto({
    required this.id,
    required this.abbreviation,
    required this.city,
    required this.conference,
    required this.division,
    required this.fullName,
    required this.name,
  });

  factory BalldontlieTeamDto.fromJson(Map<String, dynamic> json) =>
      _$BalldontlieTeamDtoFromJson(json);
}

@JsonSerializable()
class BalldontlieGameDto {
  final int id;
  final String date;
  @JsonKey(name: 'home_team')
  final BalldontlieTeamDto homeTeam;
  @JsonKey(name: 'visitor_team')
  final BalldontlieTeamDto visitorTeam;
  @JsonKey(name: 'home_team_score')
  final int homeTeamScore;
  @JsonKey(name: 'visitor_team_score')
  final int visitorTeamScore;
  final int season;
  final String status;

  BalldontlieGameDto({
    required this.id,
    required this.date,
    required this.homeTeam,
    required this.visitorTeam,
    required this.homeTeamScore,
    required this.visitorTeamScore,
    required this.season,
    required this.status,
  });

  factory BalldontlieGameDto.fromJson(Map<String, dynamic> json) =>
      _$BalldontlieGameDtoFromJson(json);
}

@JsonSerializable()
class BalldontlieStatsDto {
  final int id;
  final int ast;
  final int blk;
  final int pts;
  final int reb;
  final BalldontliePlayerDto player;
  final BalldontlieGameDto game;

  BalldontlieStatsDto({
    required this.id,
    required this.ast,
    required this.blk,
    required this.pts,
    required this.reb,
    required this.player,
    required this.game,
  });

  factory BalldontlieStatsDto.fromJson(Map<String, dynamic> json) =>
      _$BalldontlieStatsDtoFromJson(json);
}

@JsonSerializable()
class BalldontlieSeasonAverageDto {
  @JsonKey(name: 'games_played')
  final int gamesPlayed;
  final int season;
  final double pts;
  final double ast;
  final double reb;

  BalldontlieSeasonAverageDto({
    required this.gamesPlayed,
    required this.season,
    required this.pts,
    required this.ast,
    required this.reb,
  });

  factory BalldontlieSeasonAverageDto.fromJson(Map<String, dynamic> json) =>
      _$BalldontlieSeasonAverageDtoFromJson(json);
}

@JsonSerializable(genericArgumentFactories: true)
class BalldontlieResponse<T> {
  final List<T> data;
  final Map<String, dynamic>? meta;

  BalldontlieResponse({required this.data, this.meta});

  factory BalldontlieResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BalldontlieResponseFromJson(json, fromJsonT);
}
