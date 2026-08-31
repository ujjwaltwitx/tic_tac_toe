import 'bot_difficulty.dart';
import 'game_mode.dart';
import 'game_snapshot.dart';
import 'ports/game_board_port.dart';

class GameBoardEngine implements GameBoardPort {
  GameBoardEngine({
    GameMode mode = GameMode.vsFriend,
    BotDifficulty difficulty = BotDifficulty.medium,
  }) : _mode = mode,
       _difficulty = difficulty {
    initialize();
  }

  final GameMode _mode;
  BotDifficulty _difficulty;
  List<List<String>> _board = [];
  String currentPlayer = 'X';
  bool isGameFinished = false;
  String winner = '';
  String draw = '';

  @override
  List<List<String>> get board => _board;

  @override
  GameSnapshot get snapshot => GameSnapshot(
    board: _board.map((row) => List<String>.from(row)).toList(),
    currentPlayer: currentPlayer,
    isGameFinished: isGameFinished,
    winner: winner,
    isDraw: draw == 'Draw',
    mode: _mode,
    difficulty: _difficulty,
  );

  @override
  void initialize() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    currentPlayer = 'X';
    isGameFinished = false;
    winner = '';
    draw = '';
  }

  @override
  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == currentPlayer &&
          _board[i][1] == currentPlayer &&
          _board[i][2] == currentPlayer) {
        winner = currentPlayer;
        isGameFinished = true;
        return;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (_board[0][i] == currentPlayer &&
          _board[1][i] == currentPlayer &&
          _board[2][i] == currentPlayer) {
        winner = currentPlayer;
        isGameFinished = true;
        return;
      }
    }
    if (_board[0][0] == currentPlayer &&
        _board[1][1] == currentPlayer &&
        _board[2][2] == currentPlayer) {
      winner = currentPlayer;
      isGameFinished = true;
      return;
    }
    if (_board[0][2] == currentPlayer &&
        _board[1][1] == currentPlayer &&
        _board[2][0] == currentPlayer) {
      winner = currentPlayer;
      isGameFinished = true;
      return;
    }
  }

  @override
  void checkDraw() {
    if (isBoardFull() && winner == '') {
      draw = 'Draw';
      isGameFinished = true;
    }
  }

  @override
  void makeMove(int row, int col) {
    if (isGameFinished) {
      return;
    }
    if (row < 0 || row > 2 || col < 0 || col > 2) {
      return;
    }
    if (_board[row][col] != '') {
      return;
    }
    _board[row][col] = currentPlayer;
    checkWinner();
    checkDraw();
    if (!isGameFinished) {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }
  }

  @override
  void resetGame() {
    initialize();
  }

  @override
  void setDifficulty(BotDifficulty difficulty) {
    if (_mode != GameMode.vsCpu) {
      return;
    }
    _difficulty = difficulty;
  }

  bool isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }
}
