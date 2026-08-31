import '../app_settings.dart';

abstract interface class AppSettingsPort {
  Future<AppSettings> load();
  Future<void> save(AppSettings settings);
}
