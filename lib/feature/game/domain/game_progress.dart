import 'date_key.dart';
import 'day_history.dart';

class GameProgress {
  const GameProgress({
    required this.dailyPlayStreak,
    this.lastPlayDate,
    this.days = const [],
  });

  final int dailyPlayStreak;
  final String? lastPlayDate;
  final List<DayHistory> days;

  bool get playedToday => lastPlayDate == DateKey.today();
}
