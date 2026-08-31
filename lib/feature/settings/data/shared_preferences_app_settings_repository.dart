import 'package:shared_preferences/shared_preferences.dart';

import '../domain/app_settings.dart';
import '../domain/ports/app_settings_port.dart';

class SharedPreferencesAppSettingsRepository implements AppSettingsPort {
  SharedPreferencesAppSettingsRepository(this._prefs);

  static const _soundKey = 'settings_sound_enabled';
  static const _hapticsKey = 'settings_haptics_enabled';

  final SharedPreferences _prefs;

  @override
  Future<AppSettings> load() async {
    return AppSettings(
      soundEnabled: _prefs.getBool(_soundKey) ?? true,
      hapticsEnabled: _prefs.getBool(_hapticsKey) ?? true,
    );
  }

  @override
  Future<void> save(AppSettings settings) async {
    await _prefs.setBool(_soundKey, settings.soundEnabled);
    await _prefs.setBool(_hapticsKey, settings.hapticsEnabled);
  }
}
