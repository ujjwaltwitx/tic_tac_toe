import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/winning_line.dart';
import '../../../../shared/custom_theme_data.dart';

class AnimatedWinningLine extends StatefulWidget {
  const AnimatedWinningLine({
    super.key,
    required this.line,
    required this.onCompleted,
  });

  final WinningLine? line;
  final VoidCallback onCompleted;

  @override
  State<AnimatedWinningLine> createState() => _AnimatedWinningLineState();
}

class _AnimatedWinningLineState extends State<AnimatedWinningLine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  WinningLine? _animatedLine;
  bool _notified = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_notified) {
        _notified = true;
        widget.onCompleted();
      }
    });
    _maybeStart(widget.line);
  }

  @override
  void didUpdateWidget(AnimatedWinningLine oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.line != oldWidget.line) {
      _maybeStart(widget.line);
    }
  }

  void _maybeStart(WinningLine? line) {
    if (line == null) {
      _animatedLine = null;
      _notified = false;
      _controller.reset();
      return;
    }
    if (line == _animatedLine) {
      return;
    }
    _animatedLine = line;
    _notified = false;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final line = _animatedLine;
    if (line == null) {
      return const SizedBox.expand();
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _WinningLinePainter(
            line: line,
            progress: Curves.easeOutCubic.transform(_controller.value),
            color: CustomThemeData.colorForMark(line.mark),
          ),
        );
      },
    );
  }
}

class _WinningLinePainter extends CustomPainter {
  _WinningLinePainter({
    required this.line,
    required this.progress,
    required this.color,
  });

  final WinningLine line;
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || line.cells.length < 2) {
      return;
    }
    final cellW = size.width / 3;
    final cellH = size.height / 3;
    Offset centerOf((int row, int col) cell) {
      return Offset((cell.$2 + 0.5) * cellW, (cell.$1 + 0.5) * cellH);
    }

    final start = centerOf(line.cells.first);
    final end = centerOf(line.cells.last);
    final delta = end - start;
    final length = delta.distance;
    if (length == 0) {
      return;
    }
    final overflow = math.min(cellW, cellH) * 0.42;
    final direction = delta / length;
    final extendedStart = start - direction * overflow;
    final extendedEnd = end + direction * overflow;
    final path = Path()
      ..moveTo(extendedStart.dx, extendedStart.dy)
      ..lineTo(extendedEnd.dx, extendedEnd.dy);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) {
      return;
    }
    final metric = metrics.first;
    final drawn = metric.extractPath(0, metric.length * progress);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(drawn, paint);
  }

  @override
  bool shouldRepaint(covariant _WinningLinePainter oldDelegate) {
    return oldDelegate.line != line ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}
