import '../bot_difficulty.dart';
import '../game_snapshot.dart';

abstract interface class GameBoardPort {
  GameSnapshot get snapshot;
  void initialize();
  void checkWinner();
  void checkDraw();
  void makeMove(int row, int col);
  void resetGame();
  void setDifficulty(BotDifficulty difficulty);
  List<List<String>> get board;
}
