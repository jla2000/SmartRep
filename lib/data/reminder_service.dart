import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'reminder_time.dart';

/// The notification's `payload` field, so the tap handler (wired up by the
/// presentation layer in a later group) knows to deep-link to the weigh-in
/// entry screen (W-5).
const String weighInDeepLinkPayload = 'weigh-in';

/// The single notification id the daily weigh-in reminder is scheduled
/// under; scheduling again with the same id replaces the previous one.
const int weighInNotificationId = 1;

/// Thin seam over [FlutterLocalNotificationsPlugin] so [ReminderService] can
/// be unit-tested with a fake instead of touching real platform channels.
abstract class NotificationScheduler {
  Future<void> initialize();

  Future<void> zonedScheduleDaily({
    required int id,
    required tz.TZDateTime scheduledDate,
    required String title,
    required String body,
    required String payload,
  });

  Future<void> cancel(int id);
}

/// Real [NotificationScheduler] backed by `flutter_local_notifications`.
///
/// Uses [AndroidScheduleMode.inexactAllowWhileIdle] so no exact-alarm
/// permission is required: a daily reminder doesn't need to-the-second
/// precision, and inexact scheduling keeps the requested permission set
/// minimal (see AndroidManifest.xml).
class PluginNotificationScheduler implements NotificationScheduler {
  PluginNotificationScheduler([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _androidChannelId = 'weigh_in_reminder';
  static const _androidChannelName = 'Weigh-in reminder';

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    final localTimezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimezone.identifier));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
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

  @override
  Future<void> zonedScheduleDaily({
    required int id,
    required tz.TZDateTime scheduledDate,
    required String title,
    required String body,
    required String payload,
  }) {
    return _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannelId,
          _androidChannelName,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  @override
  Future<void> cancel(int id) => _plugin.cancel(id: id);
}

/// Schedules/cancels the daily weigh-in reminder (W-5). Depends only on the
/// [NotificationScheduler] seam, not the concrete plugin, so it can be unit
/// tested with a fake.
class ReminderService {
  ReminderService(this._scheduler, {tz.TZDateTime Function()? now})
    : _now = now ?? (() => tz.TZDateTime.now(tz.local));

  final NotificationScheduler _scheduler;
  final tz.TZDateTime Function() _now;

  Future<void> initialize() => _scheduler.initialize();

  /// Schedules a daily repeating reminder at [time] (local time), deep
  /// linking to the weigh-in entry screen. Repeats indefinitely until
  /// [cancel] is called; calling this again reschedules (same notification
  /// id) at the new time.
  Future<void> scheduleDaily(ReminderTime time) {
    return _scheduler.zonedScheduleDaily(
      id: weighInNotificationId,
      scheduledDate: _nextInstanceOf(time),
      title: 'Time to weigh in',
      body: "Log today's weight in SmartRep.",
      payload: weighInDeepLinkPayload,
    );
  }

  /// Cancels the daily reminder, if one is scheduled.
  Future<void> cancel() => _scheduler.cancel(weighInNotificationId);

  /// The next occurrence of [time] from now, today if it hasn't passed yet,
  /// otherwise tomorrow. `matchDateTimeComponents: DateTimeComponents.time`
  /// (passed by [PluginNotificationScheduler]) then makes the plugin repeat
  /// it daily at that time.
  tz.TZDateTime _nextInstanceOf(ReminderTime time) {
    final now = _now();
    var scheduled = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (!scheduled.isAfter(now)) {
      // Calendar arithmetic, not `.add(Duration(days: 1))`: adding an absolute
      // 24 h across a DST transition would shift the wall-clock time.
      scheduled = tz.TZDateTime(
        now.location,
        now.year,
        now.month,
        now.day + 1,
        time.hour,
        time.minute,
      );
    }
    return scheduled;
  }
}
