import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

import '../domain/ports/app_settings_port.dart';

class MoveFeedback {
  MoveFeedback({required AppSettingsPort settings}) : _settings = settings;

  final AppSettingsPort _settings;
  final AudioPlayer _player = AudioPlayer();

  Future<void> onUserCellTap() async {
    final settings = await _settings.load();
    if (settings.hapticsEnabled) {
      await HapticFeedback.lightImpact();
    }
    if (settings.soundEnabled) {
      await _player.stop();
      await _player.play(AssetSource('sounds/cell_tap.wav'));
    }
  }
}
