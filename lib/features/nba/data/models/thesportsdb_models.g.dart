// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thesportsdb_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TheSportsDbLeagueDto _$TheSportsDbLeagueDtoFromJson(
        Map<String, dynamic> json) =>
    TheSportsDbLeagueDto(
      idLeague: json['idLeague'] as String?,
      strLeague: json['strLeague'] as String?,
      strSport: json['strSport'] as String?,
      strLeagueAlternate: json['strLeagueAlternate'] as String?,
    );

Map<String, dynamic> _$TheSportsDbLeagueDtoToJson(
        TheSportsDbLeagueDto instance) =>
    <String, dynamic>{
      'idLeague': instance.idLeague,
      'strLeague': instance.strLeague,
      'strSport': instance.strSport,
      'strLeagueAlternate': instance.strLeagueAlternate,
    };

TheSportsDbTeamDto _$TheSportsDbTeamDtoFromJson(Map<String, dynamic> json) =>
    TheSportsDbTeamDto(
      idTeam: json['idTeam'] as String?,
      strTeam: json['strTeam'] as String?,
      strTeamShort: json['strTeamShort'] as String?,
      strAlternate: json['strAlternate'] as String?,
      intFormedYear: json['intFormedYear'] as String?,
      strStadium: json['strStadium'] as String?,
      strDescriptionEN: json['strDescriptionEN'] as String?,
    );

Map<String, dynamic> _$TheSportsDbTeamDtoToJson(TheSportsDbTeamDto instance) =>
    <String, dynamic>{
      'idTeam': instance.idTeam,
      'strTeam': instance.strTeam,
      'strTeamShort': instance.strTeamShort,
      'strAlternate': instance.strAlternate,
      'intFormedYear': instance.intFormedYear,
      'strStadium': instance.strStadium,
      'strDescriptionEN': instance.strDescriptionEN,
    };

TheSportsDbPlayerDto _$TheSportsDbPlayerDtoFromJson(
        Map<String, dynamic> json) =>
    TheSportsDbPlayerDto(
      idPlayer: json['idPlayer'] as String?,
      strPlayer: json['strPlayer'] as String?,
      strTeam: json['strTeam'] as String?,
      strPosition: json['strPosition'] as String?,
      dateBorn: json['dateBorn'] as String?,
      strHeight: json['strHeight'] as String?,
      strWeight: json['strWeight'] as String?,
    );

Map<String, dynamic> _$TheSportsDbPlayerDtoToJson(
        TheSportsDbPlayerDto instance) =>
    <String, dynamic>{
      'idPlayer': instance.idPlayer,
      'strPlayer': instance.strPlayer,
      'strTeam': instance.strTeam,
      'strPosition': instance.strPosition,
      'dateBorn': instance.dateBorn,
      'strHeight': instance.strHeight,
      'strWeight': instance.strWeight,
    };

TheSportsDbEventDto _$TheSportsDbEventDtoFromJson(Map<String, dynamic> json) =>
    TheSportsDbEventDto(
      idEvent: json['idEvent'] as String?,
      strEvent: json['strEvent'] as String?,
      strHomeTeam: json['strHomeTeam'] as String?,
      strAwayTeam: json['strAwayTeam'] as String?,
      intHomeScore: json['intHomeScore'] as String?,
      intAwayScore: json['intAwayScore'] as String?,
      dateEvent: json['dateEvent'] as String?,
      strTime: json['strTime'] as String?,
    );

Map<String, dynamic> _$TheSportsDbEventDtoToJson(
        TheSportsDbEventDto instance) =>
    <String, dynamic>{
      'idEvent': instance.idEvent,
      'strEvent': instance.strEvent,
      'strHomeTeam': instance.strHomeTeam,
      'strAwayTeam': instance.strAwayTeam,
      'intHomeScore': instance.intHomeScore,
      'intAwayScore': instance.intAwayScore,
      'dateEvent': instance.dateEvent,
      'strTime': instance.strTime,
    };
