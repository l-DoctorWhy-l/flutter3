class SportsLeague {
  final String id;
  final String name;
  final String sport;
  final String alternateName;

  SportsLeague({
    required this.id,
    required this.name,
    required this.sport,
    required this.alternateName,
  });
}

class SportsTeam {
  final String id;
  final String name;
  final String shortName;
  final String formedYear;
  final String stadium;
  final String description;

  SportsTeam({
    required this.id,
    required this.name,
    required this.shortName,
    required this.formedYear,
    required this.stadium,
    required this.description,
  });
}

class SportsPlayer {
  final String id;
  final String name;
  final String teamName;
  final String position;
  final String height;
  final String weight;

  SportsPlayer({
    required this.id,
    required this.name,
    required this.teamName,
    required this.position,
    required this.height,
    required this.weight,
  });
}

class SportsEvent {
  final String id;
  final String eventName;
  final String homeTeam;
  final String awayTeam;
  final String homeScore;
  final String awayScore;
  final String date;
  final String time;

  SportsEvent({
    required this.id,
    required this.eventName,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.date,
    required this.time,
  });
}

