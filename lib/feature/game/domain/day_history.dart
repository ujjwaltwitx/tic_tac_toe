class DayHistory {
  const DayHistory({
    required this.date,
    required this.xWins,
    required this.oWins,
    this.winsVsEasy = 0,
    this.winsVsMedium = 0,
    this.winsVsHard = 0,
    this.winsVsFriend = 0,
  });

  final String date;
  final int xWins;
  final int oWins;
  final int winsVsEasy;
  final int winsVsMedium;
  final int winsVsHard;
  final int winsVsFriend;

  String get title {
    if (xWins > oWins) {
      return 'Win';
    }
    if (oWins > xWins) {
      return 'Loss';
    }
    return 'Draw';
  }

  Map<String, dynamic> toJson() => {
    'xWins': xWins,
    'oWins': oWins,
    'winsVsEasy': winsVsEasy,
    'winsVsMedium': winsVsMedium,
    'winsVsHard': winsVsHard,
    'winsVsFriend': winsVsFriend,
  };

  factory DayHistory.fromJson(String date, Map<String, dynamic> json) {
    return DayHistory(
      date: date,
      xWins: json['xWins'] as int? ?? 0,
      oWins: json['oWins'] as int? ?? 0,
      winsVsEasy: json['winsVsEasy'] as int? ?? 0,
      winsVsMedium: json['winsVsMedium'] as int? ?? 0,
      winsVsHard: json['winsVsHard'] as int? ?? 0,
      winsVsFriend: json['winsVsFriend'] as int? ?? 0,
    );
  }

  DayHistory copyWith({
    int? xWins,
    int? oWins,
    int? winsVsEasy,
    int? winsVsMedium,
    int? winsVsHard,
    int? winsVsFriend,
  }) {
    return DayHistory(
      date: date,
      xWins: xWins ?? this.xWins,
      oWins: oWins ?? this.oWins,
      winsVsEasy: winsVsEasy ?? this.winsVsEasy,
      winsVsMedium: winsVsMedium ?? this.winsVsMedium,
      winsVsHard: winsVsHard ?? this.winsVsHard,
      winsVsFriend: winsVsFriend ?? this.winsVsFriend,
    );
  }
}
