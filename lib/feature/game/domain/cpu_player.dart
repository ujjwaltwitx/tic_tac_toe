import 'dart:math';

import 'bot_difficulty.dart';
import 'game_snapshot.dart';
import 'ports/cpu_player_port.dart';

class CpuPlayer implements CpuPlayerPort {
  CpuPlayer({Random? random}) : _random = random ?? Random();

  static const String _cpu = 'O';
  static const String _human = 'X';

  final Random _random;

  @override
  (int row, int col) pickMove(GameSnapshot snapshot) {
    final board = snapshot.copyBoard();
    final empties = _emptyCells(board);
    if (empties.isEmpty) {
      throw StateError('No empty cells for CPU move');
    }

    switch (snapshot.difficulty) {
      case BotDifficulty.easy:
        return empties[_random.nextInt(empties.length)];
      case BotDifficulty.medium:
        return _mediumMove(board, empties);
      case BotDifficulty.hard:
        return _hardMove(board);
    }
  }

  (int, int) _mediumMove(List<List<String>> board, List<(int, int)> empties) {
    final win = _findWinningMove(board, _cpu, empties);
    if (win != null) {
      return win;
    }
    final block = _findWinningMove(board, _human, empties);
    if (block != null) {
      return block;
    }
    return empties[_random.nextInt(empties.length)];
  }

  (int, int) _hardMove(List<List<String>> board) {
    var bestScore = -999;
    var bestMove = (0, 0);
    for (final cell in _emptyCells(board)) {
      board[cell.$1][cell.$2] = _cpu;
      final score = _minimax(board, isCpuTurn: false);
      board[cell.$1][cell.$2] = '';
      if (score > bestScore) {
        bestScore = score;
        bestMove = cell;
      }
    }
    return bestMove;
  }

  int _minimax(List<List<String>> board, {required bool isCpuTurn}) {
    final winner = _winnerOf(board);
    if (winner == _cpu) {
      return 10;
    }
    if (winner == _human) {
      return -10;
    }
    final empties = _emptyCells(board);
    if (empties.isEmpty) {
      return 0;
    }

    if (isCpuTurn) {
      var best = -999;
      for (final cell in empties) {
        board[cell.$1][cell.$2] = _cpu;
        best = max(best, _minimax(board, isCpuTurn: false));
        board[cell.$1][cell.$2] = '';
      }
      return best;
    }

    var best = 999;
    for (final cell in empties) {
      board[cell.$1][cell.$2] = _human;
      best = min(best, _minimax(board, isCpuTurn: true));
      board[cell.$1][cell.$2] = '';
    }
    return best;
  }

  (int, int)? _findWinningMove(
    List<List<String>> board,
    String mark,
    List<(int, int)> empties,
  ) {
    for (final cell in empties) {
      board[cell.$1][cell.$2] = mark;
      final wins = _winnerOf(board) == mark;
      board[cell.$1][cell.$2] = '';
      if (wins) {
        return cell;
      }
    }
    return null;
  }

  List<(int, int)> _emptyCells(List<List<String>> board) {
    final cells = <(int, int)>[];
    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          cells.add((row, col));
        }
      }
    }
    return cells;
  }

  String? _winnerOf(List<List<String>> board) {
    for (var i = 0; i < 3; i++) {
      if (board[i][0] != '' &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return board[i][0];
      }
      if (board[0][i] != '' &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return board[0][i];
      }
    }
    if (board[0][0] != '' &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return board[0][0];
    }
    if (board[0][2] != '' &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return board[0][2];
    }
    return null;
  }
}
