import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/daily_challenge_scheduler.dart';
import '../../domain/bot_difficulty.dart';
import '../../domain/game_mode.dart';
import '../../domain/game_snapshot.dart';
import '../../domain/ports/cpu_player_port.dart';
import '../../domain/ports/game_board_port.dart';
import '../../domain/ports/game_progress_port.dart';
import 'package:tic_tac_toe/feature/settings/data/move_feedback.dart';
import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required GameBoardPort engine,
    required CpuPlayerPort cpuPlayer,
    required GameProgressPort progress,
    required DailyChallengeScheduler scheduler,
    required MoveFeedback moveFeedback,
  }) : _engine = engine,
       _cpuPlayer = cpuPlayer,
       _progress = progress,
       _scheduler = scheduler,
       _moveFeedback = moveFeedback,
       super(_initial(engine.snapshot));

  final GameBoardPort _engine;
  final CpuPlayerPort _cpuPlayer;
  final GameProgressPort _progress;
  final DailyChallengeScheduler _scheduler;
  final MoveFeedback _moveFeedback;
  int _cpuJob = 0;

  static GameState _initial(GameSnapshot snapshot) {
    return GameState(
      board: snapshot.board,
      currentPlayer: snapshot.currentPlayer,
      isGameFinished: snapshot.isGameFinished,
      winner: snapshot.winner,
      isDraw: snapshot.isDraw,
      mode: snapshot.mode,
      difficulty: snapshot.difficulty,
    );
  }

  GameState _fromSnapshot(
    GameSnapshot snapshot, {
    bool? isCpuThinking,
    int? todayPlayerWins,
    int? round,
  }) {
    return GameState(
      board: snapshot.board,
      currentPlayer: snapshot.currentPlayer,
      isGameFinished: snapshot.isGameFinished,
      winner: snapshot.winner,
      isDraw: snapshot.isDraw,
      mode: snapshot.mode,
      difficulty: snapshot.difficulty,
      isCpuThinking: isCpuThinking ?? false,
      todayPlayerWins: todayPlayerWins ?? state.todayPlayerWins,
      round: round ?? state.round,
      winningLine: snapshot.winningLine,
    );
  }

  void onCellTapped(int row, int col) {
    if (!state.inputEnabled) {
      return;
    }
    if (state.board[row][col] != '') {
      return;
    }
    _engine.makeMove(row, col);
    _moveFeedback.onUserCellTap();
    _afterMove();
  }

  void onNewGame() {
    _cpuJob++;
    final nextRound = state.isGameFinished ? state.round + 1 : state.round;
    _engine.resetGame();
    emit(_fromSnapshot(_engine.snapshot, round: nextRound));
  }

  void onDifficultyChanged(BotDifficulty difficulty) {
    if (state.mode != GameMode.vsCpu) {
      return;
    }
    _engine.setDifficulty(difficulty);
    emit(_fromSnapshot(_engine.snapshot, isCpuThinking: state.isCpuThinking));
  }

  void _afterMove() {
    final snapshot = _engine.snapshot;
    if (snapshot.isGameFinished && !state.isGameFinished) {
      emit(_fromSnapshot(snapshot));
      _persistFinish(snapshot);
      return;
    }
    emit(_fromSnapshot(snapshot));
    _maybePlayCpu();
  }

  Future<void> _persistFinish(GameSnapshot snapshot) async {
    final todayPlayerWins = await _progress.recordFinishedGame(
      winner: snapshot.winner,
      isDraw: snapshot.isDraw,
    );
    await _scheduler.reschedule();
    if (isClosed) {
      return;
    }
    emit(_fromSnapshot(snapshot, todayPlayerWins: todayPlayerWins));
  }

  Future<void> _maybePlayCpu() async {
    final snapshot = _engine.snapshot;
    if (snapshot.mode != GameMode.vsCpu ||
        snapshot.isGameFinished ||
        snapshot.currentPlayer != 'O') {
      return;
    }

    final job = ++_cpuJob;
    emit(_fromSnapshot(snapshot, isCpuThinking: true));
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (isClosed || job != _cpuJob) {
      return;
    }

    final move = _cpuPlayer.pickMove(_engine.snapshot);
    _engine.makeMove(move.$1, move.$2);
    if (isClosed || job != _cpuJob) {
      return;
    }
    _afterMove();
  }
}
