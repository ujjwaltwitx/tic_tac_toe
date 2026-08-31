class DayHistory {
  const DayHistory({
    required this.date,
    required this.xWins,
    required this.oWins,
  });

  final String date;
  final int xWins;
  final int oWins;

  String get title {
    if (xWins > oWins) {
      return 'Win';
    }
    if (oWins > xWins) {
      return 'Loss';
    }
    return 'Draw';
  }

  Map<String, dynamic> toJson() => {'xWins': xWins, 'oWins': oWins};

  factory DayHistory.fromJson(String date, Map<String, dynamic> json) {
    return DayHistory(
      date: date,
      xWins: json['xWins'] as int? ?? 0,
      oWins: json['oWins'] as int? ?? 0,
    );
  }

  DayHistory copyWith({int? xWins, int? oWins}) {
    return DayHistory(
      date: date,
      xWins: xWins ?? this.xWins,
      oWins: oWins ?? this.oWins,
    );
  }
}
