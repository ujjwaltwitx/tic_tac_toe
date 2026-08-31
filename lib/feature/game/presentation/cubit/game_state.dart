import '../../domain/bot_difficulty.dart';
import '../../domain/game_mode.dart';
import '../../domain/winning_line.dart';

class GameState {
  const GameState({
    required this.board,
    required this.currentPlayer,
    required this.isGameFinished,
    required this.winner,
    required this.isDraw,
    required this.mode,
    required this.difficulty,
    this.isCpuThinking = false,
    this.todayPlayerWins = 0,
    this.round = 1,
    this.winningLine,
  });

  final List<List<String>> board;
  final String currentPlayer;
  final bool isGameFinished;
  final String winner;
  final bool isDraw;
  final GameMode mode;
  final BotDifficulty difficulty;
  final bool isCpuThinking;
  final int todayPlayerWins;
  final int round;
  final WinningLine? winningLine;

  bool get inputEnabled =>
      !isGameFinished &&
      !isCpuThinking &&
      (mode == GameMode.vsFriend || currentPlayer == 'X');
}
