import '../game_snapshot.dart';

abstract interface class CpuPlayerPort {
  (int row, int col) pickMove(GameSnapshot snapshot);
}
