import '../bot_difficulty.dart';
import '../game_mode.dart';
import '../game_progress.dart';

abstract interface class GameProgressPort {
  Future<GameProgress> load();

  /// Records the match and returns how many times the user (X) has won today.
  Future<int> recordFinishedGame({
    required String winner,
    required bool isDraw,
    required GameMode mode,
    required BotDifficulty difficulty,
  });
}
