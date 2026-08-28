import 'ports/game_board_port.dart';

class GameBoardEngine implements GameBoardPort {
  GameBoardEngine() {
    initialize();
  }

  List<List<String>> board = [];
  String currentPlayer = "X";
  bool isGameFinished = false;
  String winner = "";
  String draw = "";

  @override
  void initialize() {
    board = List.generate(3, (index) => List.generate(3, (index) => ""));
  }

  @override
  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer) {
        winner = currentPlayer;
        isGameFinished = true;
        return;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == currentPlayer &&
          board[1][i] == currentPlayer &&
          board[2][i] == currentPlayer) {
        winner = currentPlayer;
        isGameFinished = true;
        return;
      }
    }
    if (board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      winner = currentPlayer;
      isGameFinished = true;
      return;
    }
    if (board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      winner = currentPlayer;
      isGameFinished = true;
      return;
    }
  }

  @override
  void checkDraw() {
    if (isBoardFull() && winner == "") {
      draw = "Draw";
      isGameFinished = true;
      return;
    }
  }

  @override
  void makeMove(int row, int col) {
    board[row][col] = currentPlayer;
    currentPlayer = currentPlayer == "X" ? "O" : "X";
    checkWinner();
    checkDraw();
  }

  @override
  void resetGame() {
    board = List.generate(3, (index) => List.generate(3, (index) => ""));
  }

  bool isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          return false;
        }
      }
    }
    return true;
  }
}
