import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/app_settings.dart';
import '../../domain/ports/app_settings_port.dart';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit(this._settings) : super(const AppSettings()) {
    load();
  }

  final AppSettingsPort _settings;

  Future<void> load() async {
    emit(await _settings.load());
  }

  Future<void> setSoundEnabled(bool enabled) async {
    final next = state.copyWith(soundEnabled: enabled);
    await _settings.save(next);
    emit(next);
  }

  Future<void> setHapticsEnabled(bool enabled) async {
    final next = state.copyWith(hapticsEnabled: enabled);
    await _settings.save(next);
    emit(next);
  }
}
