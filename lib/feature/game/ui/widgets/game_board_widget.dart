import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../shared/utilities/positioning.dart';
import '../../domain/ports/game_board_port.dart';

class GameBoardWidget extends StatelessWidget {
  final GameBoardPort gameBoardEngine;
  const GameBoardWidget({super.key, required this.gameBoardEngine});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Positioning.getAssetSize(300),
      height: Positioning.getAssetSize(300),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned.fill(child: IgnorePointer(child: HandDrawnGrid())),
          Column(
            children: [
              for (int row = 0; row < 3; row++)
                Row(
                  children: [
                    for (int col = 0; col < 3; col++)
                      SizedBox(
                        width: Positioning.getAssetSize(100),
                        height: Positioning.getAssetSize(100),
                        child: Cell(
                          row: row,
                          col: col,
                          gameBoardEngine: gameBoardEngine,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class Cell extends StatefulWidget {
  final int row;
  final int col;
  final GameBoardPort gameBoardEngine;
  const Cell({
    super.key,
    required this.row,
    required this.col,
    required this.gameBoardEngine,
  });

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.gameBoardEngine.board[widget.row][widget.col] != "") {
          return;
        }
        widget.gameBoardEngine.makeMove(widget.row, widget.col);
        setState(() {});
      },
      child: Container(
        width: Positioning.getAssetSize(100),
        height: Positioning.getAssetSize(100),
        alignment: Alignment.center,
        child: Text(
          widget.gameBoardEngine.board[widget.row][widget.col] ?? '',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF162839),
          ),
        ),
      ),
    );
  }
}

class HandDrawnGrid extends StatelessWidget {
  const HandDrawnGrid({super.key});

  static const Color _ink = Color(0xFF162839);
  static const double _stroke = 3;
  static const double _bleed = 6;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Container(color: Colors.red),
            _horizontalStroke(
              top: h / 3,
              rotateDeg: 1,
              alignment: Alignment.centerLeft,
            ),
            _horizontalStroke(
              top: 2 * h / 3,
              rotateDeg: -1,
              alignment: Alignment.centerRight,
            ),
            _verticalStroke(
              left: w / 3,
              rotateDeg: -1,
              alignment: Alignment.topCenter,
            ),
            _verticalStroke(
              left: 2 * w / 3,
              rotateDeg: 1,
              alignment: Alignment.bottomCenter,
            ),
            // _inkBleed(left: w / 3, top: h / 3),
            // _inkBleed(left: 2 * w / 3, top: h / 3),
            // _inkBleed(left: w / 3, top: 2 * h / 3),
            // _inkBleed(left: 2 * w / 3, top: 2 * h / 3),
          ],
        );
      },
    );
  }

  Widget _horizontalStroke({
    required double top,
    required double rotateDeg,
    required Alignment alignment,
  }) {
    return Positioned(
      top: top - _stroke / 2,
      left: 0,
      right: 0,
      height: _stroke,
      child: Transform.rotate(
        angle: rotateDeg * math.pi / 180,
        alignment: alignment,
        child: Transform.scale(
          scaleX: 1.05,
          alignment: alignment,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _ink.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(_stroke),
            ),
          ),
        ),
      ),
    );
  }

  Widget _verticalStroke({
    required double left,
    required double rotateDeg,
    required Alignment alignment,
  }) {
    return Positioned(
      left: left - _stroke / 2,
      top: 0,
      bottom: 0,
      width: _stroke,
      child: Transform.rotate(
        angle: rotateDeg * math.pi / 180,
        alignment: alignment,
        child: Transform.scale(
          scaleY: 1.05,
          alignment: alignment,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _ink.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(_stroke),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inkBleed({required double left, required double top}) {
    return Positioned(
      left: left - _bleed / 2,
      top: top - _bleed / 2,
      width: _bleed,
      height: _bleed,
      child: const DecoratedBox(
        decoration: BoxDecoration(color: _ink, shape: BoxShape.circle),
      ),
    );
  }
}
