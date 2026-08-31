import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../domain/date_key.dart';
import '../domain/ports/game_progress_port.dart';

class DailyChallengeScheduler {
  DailyChallengeScheduler({
    required SharedPreferences prefs,
    required GameProgressPort progress,
    Random? random,
    FlutterLocalNotificationsPlugin? plugin,
  }) : _prefs = prefs,
       _progress = progress,
       _random = random ?? Random(),
       _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _morningId = 1001;
  static const _afternoonId = 1002;
  static const _eveningId = 1003;
  static const _dateKey = 'notif_date';
  static const _morningMsKey = 'notif_morning_ms';
  static const _afternoonMsKey = 'notif_afternoon_ms';
  static const _eveningMsKey = 'notif_evening_ms';

  final SharedPreferences _prefs;
  final GameProgressPort _progress;
  final Random _random;
  final FlutterLocalNotificationsPlugin _plugin;

  Future<void> init() async {
    tz_data.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(_locationFor(timeZoneName));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> reschedule() async {
    final progress = await _progress.load();
    await _plugin.cancel(_morningId);
    await _plugin.cancel(_afternoonId);
    await _plugin.cancel(_eveningId);

    final target = progress.playedToday
        ? DateTime.now().add(const Duration(days: 1))
        : DateTime.now();
    await _scheduleDay(target);
  }

  Future<void> _scheduleDay(DateTime calendarDay) async {
    final dateKey = DateKey.fromDate(calendarDay);
    final times = await _timesFor(dateKey, calendarDay);
    final now = tz.TZDateTime.now(tz.local);

    await _maybeSchedule(_morningId, times.morning, now);
    await _maybeSchedule(_afternoonId, times.afternoon, now);
    await _maybeSchedule(_eveningId, times.evening, now);
  }

  Future<
      ({tz.TZDateTime morning, tz.TZDateTime afternoon, tz.TZDateTime evening})>
  _timesFor(String dateKey, DateTime calendarDay) async {
    final morningMs = _prefs.getInt(_morningMsKey);
    final afternoonMs = _prefs.getInt(_afternoonMsKey);
    final eveningMs = _prefs.getInt(_eveningMsKey);
    if (_prefs.getString(_dateKey) == dateKey &&
        morningMs != null &&
        afternoonMs != null &&
        eveningMs != null) {
      return (
        morning: _fromMillis(morningMs),
        afternoon: _fromMillis(afternoonMs),
        evening: _fromMillis(eveningMs),
      );
    }

    final morning = _randomInWindow(calendarDay, hour: 8, minutes: 120);
    final afternoon = _randomInWindow(calendarDay, hour: 13, minutes: 60);
    final evening = _randomInWindow(calendarDay, hour: 20, minutes: 60);

    await _prefs.setString(_dateKey, dateKey);
    await _prefs.setInt(_morningMsKey, morning.millisecondsSinceEpoch);
    await _prefs.setInt(_afternoonMsKey, afternoon.millisecondsSinceEpoch);
    await _prefs.setInt(_eveningMsKey, evening.millisecondsSinceEpoch);

    return (morning: morning, afternoon: afternoon, evening: evening);
  }

  tz.TZDateTime _randomInWindow(
    DateTime calendarDay, {
    required int hour,
    required int minutes,
  }) {
    final start = tz.TZDateTime(
      tz.local,
      calendarDay.year,
      calendarDay.month,
      calendarDay.day,
      hour,
    );
    final offset = _random.nextInt(minutes);
    return start.add(Duration(minutes: offset));
  }

  tz.TZDateTime _fromMillis(int millis) {
    return tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, millis);
  }

  Future<void> _maybeSchedule(
    int id,
    tz.TZDateTime when,
    tz.TZDateTime now,
  ) async {
    if (!when.isAfter(now)) {
      return;
    }
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_challenge',
        'Daily challenge',
        channelDescription: 'Reminders to play once a day and keep your streak',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.zonedSchedule(
      id,
      'Daily challenge',
      'Play once today to keep your streak.',
      when,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static tz.Location _locationFor(String name) {
    if (tz.timeZoneDatabase.locations.containsKey(name)) {
      return tz.getLocation(name);
    }
    const aliases = {
      'Asia/Calcutta': 'Asia/Kolkata',
      'Asia/Katmandu': 'Asia/Kathmandu',
      'Asia/Saigon': 'Asia/Ho_Chi_Minh',
      'Asia/Rangoon': 'Asia/Yangon',
      'US/Eastern': 'America/New_York',
      'US/Central': 'America/Chicago',
      'US/Mountain': 'America/Denver',
      'US/Pacific': 'America/Los_Angeles',
      'US/Alaska': 'America/Anchorage',
      'US/Hawaii': 'Pacific/Honolulu',
    };
    final mapped = aliases[name];
    if (mapped != null && tz.timeZoneDatabase.locations.containsKey(mapped)) {
      return tz.getLocation(mapped);
    }
    return tz.UTC;
  }
}
