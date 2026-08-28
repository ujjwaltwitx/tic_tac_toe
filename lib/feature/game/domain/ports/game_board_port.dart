abstract interface class GameBoardPort {
  void initialize();
  void checkWinner();
  void checkDraw();
  void makeMove(int row, int col);
  void resetGame();
  List<List<String>> get board;
}
