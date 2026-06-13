class Team {
  final int id;
  final String name;
  final String flag;
  final String country;
  final int points;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int goalsFor;
  final int goalsAgainst;
  final double fifaRank;
  final double eloRating;
  final List<String> recentForm;

  Team({
    required this.id,
    required this.name,
    required this.flag,
    required this.country,
    required this.points,
    required this.played,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.fifaRank,
    required this.eloRating,
    required this.recentForm,
  });

  int get goalDifference => goalsFor - goalsAgainst;
  double get goalsPerMatch => played > 0 ? goalsFor / played : 0;
}

class Match {
  final int id;
  final DateTime date;
  final String team1;
  final String team2;
  final String flag1;
  final String flag2;
  final String? result;
  final bool played;

  Match({
    required this.id,
    required this.date,
    required this.team1,
    required this.team2,
    required this.flag1,
    required this.flag2,
    this.result,
    required this.played,
  });

  bool get isUpcoming => !played && date.isAfter(DateTime.now());
}

class TeamAnalysis {
  final String teamName;
  final String flag;
  final double strength;
  final List<String> strengths;
  final List<String> weaknesses;
  final String xgData;
  final List<String> keyPlayers;
  final String nextOpponent;
  final DateTime nextMatchDate;
  final double winProbability;
  final double drawProbability;
  final double lossProbability;
  final double advanceProbability;
  final double tournamentWinChance;
  final String forecast;
  final DateTime analyzedAt;

  TeamAnalysis({
    required this.teamName,
    required this.flag,
    required this.strength,
    required this.strengths,
    required this.weaknesses,
    required this.xgData,
    required this.keyPlayers,
    required this.nextOpponent,
    required this.nextMatchDate,
    required this.winProbability,
    required this.drawProbability,
    required this.lossProbability,
    required this.advanceProbability,
    required this.tournamentWinChance,
    required this.forecast,
    required this.analyzedAt,
  });

  Map<String, dynamic> toJson() => {
    'teamName': teamName,
    'flag': flag,
    'strength': strength,
    'strengths': strengths,
    'weaknesses': weaknesses,
    'xgData': xgData,
    'keyPlayers': keyPlayers,
    'nextOpponent': nextOpponent,
    'nextMatchDate': nextMatchDate.toString(),
    'winProbability': winProbability,
    'drawProbability': drawProbability,
    'lossProbability': lossProbability,
    'advanceProbability': advanceProbability,
    'tournamentWinChance': tournamentWinChance,
    'forecast': forecast,
    'analyzedAt': analyzedAt.toString(),
  };

  factory TeamAnalysis.fromJson(Map<String, dynamic> json) => TeamAnalysis(
    teamName: json['teamName'] ?? '',
    flag: json['flag'] ?? '',
    strength: (json['strength'] ?? 50).toDouble(),
    strengths: List<String>.from(json['strengths'] ?? []),
    weaknesses: List<String>.from(json['weaknesses'] ?? []),
    xgData: json['xgData'] ?? '',
    keyPlayers: List<String>.from(json['keyPlayers'] ?? []),
    nextOpponent: json['nextOpponent'] ?? '',
    nextMatchDate: DateTime.tryParse(json['nextMatchDate'] ?? '') ?? DateTime.now(),
    winProbability: (json['winProbability'] ?? 50).toDouble(),
    drawProbability: (json['drawProbability'] ?? 25).toDouble(),
    lossProbability: (json['lossProbability'] ?? 25).toDouble(),
    advanceProbability: (json['advanceProbability'] ?? 50).toDouble(),
    tournamentWinChance: (json['tournamentWinChance'] ?? 2.5).toDouble(),
    forecast: json['forecast'] ?? '',
    analyzedAt: DateTime.tryParse(json['analyzedAt'] ?? '') ?? DateTime.now(),
  );
}

class MatchAnalysis {
  final String team1;
  final String team2;
  final String flag1;
  final String flag2;
  final DateTime matchDate;
  final String predictedScore;
  final double team1WinChance;
  final double drawChance;
  final double team2WinChance;
  final List<String> keyFactors;
  final String xgForecast;
  final String summary;
  final DateTime analyzedAt;

  MatchAnalysis({
    required this.team1,
    required this.team2,
    required this.flag1,
    required this.flag2,
    required this.matchDate,
    required this.predictedScore,
    required this.team1WinChance,
    required this.drawChance,
    required this.team2WinChance,
    required this.keyFactors,
    required this.xgForecast,
    required this.summary,
    required this.analyzedAt,
  });
}
