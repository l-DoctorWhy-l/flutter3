class NbaPlayer {
  final int id;
  final String firstName;
  final String lastName;
  final String position;
  final String teamName;

  NbaPlayer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.teamName,
  });
}

class NbaTeam {
  final int id;
  final String fullName;
  final String city;
  final String conference;

  NbaTeam({
    required this.id,
    required this.fullName,
    required this.city,
    required this.conference,
  });
}

class NbaGame {
  final int id;
  final String date;
  final String homeTeam;
  final String visitorTeam;
  final int homeScore;
  final int visitorScore;
  final String status;

  NbaGame({
    required this.id,
    required this.date,
    required this.homeTeam,
    required this.visitorTeam,
    required this.homeScore,
    required this.visitorScore,
    required this.status,
  });
}

class NbaStats {
  final int points;
  final int assists;
  final int rebounds;
  final int blocks;
  final String playerName;

  NbaStats({
    required this.points,
    required this.assists,
    required this.rebounds,
    required this.blocks,
    required this.playerName,
  });
}

class NbaSeasonStats {
  final int season;
  final double pts;
  final double ast;
  final double reb;
  final int gamesPlayed;

  NbaSeasonStats({
    required this.season,
    required this.pts,
    required this.ast,
    required this.reb,
    required this.gamesPlayed,
  });
}
