import 'package:json_annotation/json_annotation.dart';

part 'thesportsdb_models.g.dart';

@JsonSerializable()
class TheSportsDbLeagueDto {
  final String? idLeague;
  final String? strLeague;
  final String? strSport;
  final String? strLeagueAlternate;

  TheSportsDbLeagueDto({
    this.idLeague,
    this.strLeague,
    this.strSport,
    this.strLeagueAlternate,
  });

  factory TheSportsDbLeagueDto.fromJson(Map<String, dynamic> json) =>
      _$TheSportsDbLeagueDtoFromJson(json);
}

@JsonSerializable()
class TheSportsDbTeamDto {
  final String? idTeam;
  final String? strTeam;
  final String? strTeamShort;
  final String? strAlternate;
  final String? intFormedYear;
  final String? strStadium;
  final String? strDescriptionEN;

  TheSportsDbTeamDto({
    this.idTeam,
    this.strTeam,
    this.strTeamShort,
    this.strAlternate,
    this.intFormedYear,
    this.strStadium,
    this.strDescriptionEN,
  });

  factory TheSportsDbTeamDto.fromJson(Map<String, dynamic> json) =>
      _$TheSportsDbTeamDtoFromJson(json);
}

@JsonSerializable()
class TheSportsDbPlayerDto {
  final String? idPlayer;
  final String? strPlayer;
  final String? strTeam;
  final String? strPosition;
  final String? dateBorn;
  final String? strHeight;
  final String? strWeight;

  TheSportsDbPlayerDto({
    this.idPlayer,
    this.strPlayer,
    this.strTeam,
    this.strPosition,
    this.dateBorn,
    this.strHeight,
    this.strWeight,
  });

  factory TheSportsDbPlayerDto.fromJson(Map<String, dynamic> json) =>
      _$TheSportsDbPlayerDtoFromJson(json);
}

@JsonSerializable()
class TheSportsDbEventDto {
  final String? idEvent;
  final String? strEvent;
  final String? strHomeTeam;
  final String? strAwayTeam;
  final String? intHomeScore;
  final String? intAwayScore;
  final String? dateEvent;
  final String? strTime;

  TheSportsDbEventDto({
    this.idEvent,
    this.strEvent,
    this.strHomeTeam,
    this.strAwayTeam,
    this.intHomeScore,
    this.intAwayScore,
    this.dateEvent,
    this.strTime,
  });

  factory TheSportsDbEventDto.fromJson(Map<String, dynamic> json) =>
      _$TheSportsDbEventDtoFromJson(json);
}
