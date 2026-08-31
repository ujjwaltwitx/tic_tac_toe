import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/feature/game/domain/bot_difficulty.dart';
import 'package:tic_tac_toe/feature/game/domain/game_mode.dart';
import 'package:tic_tac_toe/feature/game/presentation/cubit/game_cubit.dart';
import 'package:tic_tac_toe/feature/game/presentation/cubit/game_state.dart';
import 'package:tic_tac_toe/feature/game/ui/screens/game_over_screen.dart';
import 'package:tic_tac_toe/feature/game/ui/widgets/game_board_widget.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';

import '../../../../shared/utilities/positioning.dart';
import '../../../../shared/widgets/top_bar_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen:
          (previous, current) =>
              !previous.isGameFinished &&
              current.isGameFinished &&
              current.isDraw,
      listener: (context, state) => _showGameOver(context, state),
      child: Scaffold(
        body: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: Positioning.safeAreaPaddingTop),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 0,
                    child: TopBarWidget(showBackButton: true),
                  ),
                  Positioned(
                    top: Positioning.getActualDeviceHeight(80),
                    child: _roundInfo(state),
                  ),
                  // Positioned(
                  //   top: Positioning.getActualDeviceHeight(134),
                  //   child: _playersInfo(state),
                  // ),
                  if (state.mode == GameMode.vsCpu)
                    Positioned(
                      top: Positioning.getActualDeviceHeight(150),
                      child: _difficultySwitch(context, state),
                    ),
                  Positioned(
                    top: Positioning.getActualDeviceHeight(270),
                    child: GameBoardWidget(
                      board: state.board,
                      inputEnabled: state.inputEnabled,
                      onCellTap: context.read<GameCubit>().onCellTapped,
                      winningLine: state.winningLine,
                      onWinLineCompleted: () {
                        Future<void>.delayed(
                          const Duration(milliseconds: 280),
                          () {
                            if (!context.mounted) {
                              return;
                            }
                            _showGameOver(
                              context,
                              context.read<GameCubit>().state,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (state.isCpuThinking)
                    Positioned(
                      top: Positioning.getActualDeviceHeight(600),
                      child: _cpuThinkingIndicator(),
                    ),
                  Positioned(
                    top: Positioning.getActualDeviceHeight(650),
                    child: InkWell(
                      onTap: context.read<GameCubit>().onNewGame,
                      child: Transform.rotate(
                        angle: 1 * pi / 180,
                        child: Container(
                          width: Positioning.getActualDeviceWidth(128),
                          height: Positioning.getActualDeviceHeight(52),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff162839),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'New Game',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: CustomThemeData.fontFamilyKarla,
                              color: const Color(0xffb02d21),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: Positioning.safeAreaPaddingBottom,
                  //   child: CustomNavigationBar(),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _cpuThinkingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Analyzing',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: CustomThemeData.fontFamilyKarla,
            color: const Color(0xff43474c),
          ),
        ),
        SizedBox(width: Positioning.getAssetSize(10)),
        SizedBox(
          width: Positioning.getAssetSize(16),
          height: Positioning.getAssetSize(16),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: const Color(0xff162839),
          ),
        ),
      ],
    );
  }

  Widget _difficultySwitch(BuildContext context, GameState state) {
    return SizedBox(
      width: Positioning.getActualDeviceWidth(342),
      child: SegmentedButton<BotDifficulty>(
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(value: BotDifficulty.easy, label: Text('Easy')),
          ButtonSegment(value: BotDifficulty.medium, label: Text('Medium')),
          ButtonSegment(value: BotDifficulty.hard, label: Text('Hard')),
        ],
        selected: {state.difficulty},
        onSelectionChanged: (selected) {
          context.read<GameCubit>().onDifficultyChanged(selected.first);
        },
      ),
    );
  }

  Widget _roundInfo(GameState state) {
    final turnText =
        state.isCpuThinking
            ? 'CPU thinking...'
            : "${state.currentPlayer}'s Turn";
    return Container(
      height: Positioning.getActualDeviceHeight(34),
      width: Positioning.getActualDeviceWidth(342),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xff162839),
            width: Positioning.getAssetSize(2),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            turnText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: CustomThemeData.fontFamilyKarla,
              color: const Color(0xff162839),
            ),
          ),
          Text(
            'Round ${state.round}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: CustomThemeData.fontFamilyKarla,
              color: const Color(0xff43474c),
            ),
          ),
        ],
      ),
    );
  }

  void _showGameOver(BuildContext context, GameState state) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Game over',
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return GameOverScreen(
          winner: state.winner,
          isDraw: state.isDraw,
          todayPlayerWins: state.todayPlayerWins,
          onPlayAgain: () {
            Navigator.of(dialogContext).pop();
            context.read<GameCubit>().onNewGame();
          },
          onMainMenu: () {
            Navigator.of(dialogContext).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
