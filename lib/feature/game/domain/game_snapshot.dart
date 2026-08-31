import 'bot_difficulty.dart';
import 'game_mode.dart';
import 'winning_line.dart';

class GameSnapshot {
  const GameSnapshot({
    required this.board,
    required this.currentPlayer,
    required this.isGameFinished,
    required this.winner,
    required this.isDraw,
    required this.mode,
    required this.difficulty,
    this.winningLine,
  });

  final List<List<String>> board;
  final String currentPlayer;
  final bool isGameFinished;
  final String winner;
  final bool isDraw;
  final GameMode mode;
  final BotDifficulty difficulty;
  final WinningLine? winningLine;

  List<List<String>> copyBoard() {
    return board.map((row) => List<String>.from(row)).toList();
  }
}
