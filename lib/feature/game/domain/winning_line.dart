class WinningLine {
  const WinningLine({required this.mark, required this.cells});

  final String mark;

  /// Three cells in draw order, each `(row, col)`.
  final List<(int row, int col)> cells;

  @override
  bool operator ==(Object other) {
    if (other is! WinningLine ||
        other.mark != mark ||
        other.cells.length != cells.length) {
      return false;
    }
    for (var i = 0; i < cells.length; i++) {
      if (other.cells[i] != cells[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(mark, Object.hashAll(cells));
}
