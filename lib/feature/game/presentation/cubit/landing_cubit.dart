import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/ports/game_progress_port.dart';

class LandingCubit extends Cubit<int> {
  LandingCubit(this._progress) : super(0) {
    refresh();
  }

  final GameProgressPort _progress;

  Future<void> refresh() async {
    final progress = await _progress.load();
    emit(progress.dailyPlayStreak);
  }
}
