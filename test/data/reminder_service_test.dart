import 'package:flutter_test/flutter_test.dart';
import 'package:smartrep/data/reminder_service.dart';
import 'package:smartrep/data/reminder_time.dart';
import 'package:timezone/timezone.dart' as tz;

class _FakeScheduler implements NotificationScheduler {
  bool initialized = false;
  int initializeCalls = 0;
  int cancelCalls = 0;
  int? lastCancelledId;

  final List<Map<String, Object?>> scheduleCalls = [];

  @override
  Future<void> initialize() async {
    initialized = true;
    initializeCalls++;
  }

  @override
  Future<void> zonedScheduleDaily({
    required int id,
    required tz.TZDateTime scheduledDate,
    required String title,
    required String body,
    required String payload,
  }) async {
    scheduleCalls.add({
      'id': id,
      'scheduledDate': scheduledDate,
      'title': title,
      'body': body,
      'payload': payload,
    });
  }

  @override
  Future<void> cancel(int id) async {
    cancelCalls++;
    lastCancelledId = id;
  }
}

void main() {
  late _FakeScheduler fake;

  setUp(() {
    fake = _FakeScheduler();
  });

  test('initialize delegates to the scheduler', () async {
    final service = ReminderService(fake);
    await service.initialize();

    expect(fake.initialized, isTrue);
    expect(fake.initializeCalls, 1);
  });

  test(
    'scheduleDaily schedules today when the time has not yet passed',
    () async {
      final now = tz.TZDateTime(tz.UTC, 2026, 7, 14, 6, 0);
      final service = ReminderService(fake, now: () => now);

      await service.scheduleDaily(const ReminderTime(hour: 7, minute: 30));

      expect(fake.scheduleCalls, hasLength(1));
      final call = fake.scheduleCalls.single;
      expect(call['id'], weighInNotificationId);
      expect(call['payload'], weighInDeepLinkPayload);
      final scheduledDate = call['scheduledDate'] as tz.TZDateTime;
      expect(scheduledDate.year, 2026);
      expect(scheduledDate.month, 7);
      expect(scheduledDate.day, 14);
      expect(scheduledDate.hour, 7);
      expect(scheduledDate.minute, 30);
    },
  );

  test(
    'scheduleDaily rolls over to tomorrow when the time has already passed',
    () async {
      final now = tz.TZDateTime(tz.UTC, 2026, 7, 14, 20, 0);
      final service = ReminderService(fake, now: () => now);

      await service.scheduleDaily(const ReminderTime(hour: 7, minute: 30));

      final scheduledDate =
          fake.scheduleCalls.single['scheduledDate'] as tz.TZDateTime;
      expect(scheduledDate.day, 15);
      expect(scheduledDate.hour, 7);
      expect(scheduledDate.minute, 30);
    },
  );

  test(
    'scheduleDaily rolls over to tomorrow at exactly the reminder time',
    () async {
      // "now" being exactly at the target time must not fire "today" again
      // (there'd be nothing left to schedule for).
      final now = tz.TZDateTime(tz.UTC, 2026, 7, 14, 7, 30);
      final service = ReminderService(fake, now: () => now);

      await service.scheduleDaily(const ReminderTime(hour: 7, minute: 30));

      final scheduledDate =
          fake.scheduleCalls.single['scheduledDate'] as tz.TZDateTime;
      expect(scheduledDate.day, 15);
    },
  );

  test(
    'cancel delegates to the scheduler with the reminder notification id',
    () async {
      final service = ReminderService(fake);
      await service.cancel();

      expect(fake.cancelCalls, 1);
      expect(fake.lastCancelledId, weighInNotificationId);
    },
  );
}
