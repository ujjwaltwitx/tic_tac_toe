import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/day_history.dart';
import '../../domain/ports/game_progress_port.dart';

class HistoryCubit extends Cubit<List<DayHistory>> {
  HistoryCubit(this._progress) : super(const []) {
    load();
  }

  final GameProgressPort _progress;

  Future<void> load() async {
    final progress = await _progress.load();
    emit(progress.days);
  }
}
