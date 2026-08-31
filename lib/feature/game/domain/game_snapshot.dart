import 'bot_difficulty.dart';
import 'game_mode.dart';

class GameSnapshot {
  const GameSnapshot({
    required this.board,
    required this.currentPlayer,
    required this.isGameFinished,
    required this.winner,
    required this.isDraw,
    required this.mode,
    required this.difficulty,
  });

  final List<List<String>> board;
  final String currentPlayer;
  final bool isGameFinished;
  final String winner;
  final bool isDraw;
  final GameMode mode;
  final BotDifficulty difficulty;

  List<List<String>> copyBoard() {
    return board.map((row) => List<String>.from(row)).toList();
  }
}
