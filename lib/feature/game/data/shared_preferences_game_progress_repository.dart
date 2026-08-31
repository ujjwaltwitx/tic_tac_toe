import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/date_key.dart';
import '../domain/day_history.dart';
import '../domain/game_progress.dart';
import '../domain/ports/game_progress_port.dart';

class SharedPreferencesGameProgressRepository implements GameProgressPort {
  SharedPreferencesGameProgressRepository(this._prefs);

  static const _streakKey = 'daily_play_streak';
  static const _lastPlayKey = 'last_play_date';
  static const _historyKey = 'day_history_json';

  final SharedPreferences _prefs;

  @override
  Future<GameProgress> load() async {
    var streak = _prefs.getInt(_streakKey) ?? 0;
    final lastPlay = _prefs.getString(_lastPlayKey);
    final today = DateKey.today();
    final yesterday = DateKey.yesterday();

    if (lastPlay != null && lastPlay != today && lastPlay != yesterday) {
      streak = 0;
      await _prefs.setInt(_streakKey, 0);
    }

    return GameProgress(
      dailyPlayStreak: streak,
      lastPlayDate: lastPlay,
      days: _readDays(),
    );
  }

  @override
  Future<int> recordFinishedGame({
    required String winner,
    required bool isDraw,
  }) async {
    final current = await load();
    final today = DateKey.today();
    var streak = current.dailyPlayStreak;
    if (current.lastPlayDate != today) {
      streak += 1;
    }

    final days = Map<String, DayHistory>.fromEntries(
      current.days.map((day) => MapEntry(day.date, day)),
    );
    final existing =
        days[today] ?? DayHistory(date: today, xWins: 0, oWins: 0);
    if (!isDraw) {
      if (winner == 'X') {
        days[today] = existing.copyWith(xWins: existing.xWins + 1);
      } else if (winner == 'O') {
        days[today] = existing.copyWith(oWins: existing.oWins + 1);
      }
    } else if (!days.containsKey(today)) {
      days[today] = existing;
    }

    await _prefs.setInt(_streakKey, streak);
    await _prefs.setString(_lastPlayKey, today);
    await _prefs.setString(_historyKey, _encodeDays(days.values.toList()));
    return days[today]?.xWins ?? 0;
  }

  List<DayHistory> _readDays() {
    final raw = _prefs.getString(_historyKey);
    if (raw == null || raw.isEmpty) {
      return const [];
    }
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final days = decoded.entries
        .map(
          (entry) => DayHistory.fromJson(
            entry.key,
            Map<String, dynamic>.from(entry.value as Map),
          ),
        )
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return days;
  }

  String _encodeDays(List<DayHistory> days) {
    final map = <String, dynamic>{};
    for (final day in days) {
      map[day.date] = day.toJson();
    }
    return jsonEncode(map);
  }
}
