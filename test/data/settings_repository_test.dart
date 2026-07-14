import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartrep/data/database.dart';
import 'package:smartrep/data/reminder_time.dart';
import 'package:smartrep/data/settings_repository.dart';
import 'package:smartrep/domain/units.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository settings;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    settings = SettingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('unit defaults to kg', () async {
    expect(await settings.getUnit(), WeightUnit.kg);
  });

  test('unit round-trips through kg and lb', () async {
    await settings.setUnit(WeightUnit.lb);
    expect(await settings.getUnit(), WeightUnit.lb);

    await settings.setUnit(WeightUnit.kg);
    expect(await settings.getUnit(), WeightUnit.kg);
  });

  test('reminder is disabled by default (W-5)', () async {
    expect(await settings.getReminderEnabled(), isFalse);
  });

  test('reminder enabled round-trips', () async {
    await settings.setReminderEnabled(true);
    expect(await settings.getReminderEnabled(), isTrue);

    await settings.setReminderEnabled(false);
    expect(await settings.getReminderEnabled(), isFalse);
  });

  test('reminder time is unset by default', () async {
    expect(await settings.getReminderTime(), isNull);
  });

  test('reminder time round-trips', () async {
    await settings.setReminderTime(const ReminderTime(hour: 7, minute: 30));
    final time = await settings.getReminderTime();

    expect(time, const ReminderTime(hour: 7, minute: 30));
  });

  test('setting a key twice overwrites, not duplicates', () async {
    await settings.setUnit(WeightUnit.lb);
    await settings.setUnit(WeightUnit.kg);

    final rows = await db.select(db.settings).get();
    expect(rows.where((r) => r.key == SettingsKeys.unit), hasLength(1));
  });
}
