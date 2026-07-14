import 'database.dart';
import '../domain/units.dart';
import 'reminder_time.dart';

/// Keys used in the [Settings] key/value table. Kept in one place so future
/// groups (e.g. advice display style) can add a key without touching the
/// storage mechanics below.
class SettingsKeys {
  SettingsKeys._();

  static const unit = 'unit';
  static const reminderEnabled = 'reminder_enabled';
  static const reminderTime = 'reminder_time';
}

/// Typed accessors over the freeform [Settings] table (SPEC §4.3).
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Future<String?> _read(String key) async {
    final row = await (_db.select(
      _db.settings,
    )..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> _write(String key, String value) {
    return _db
        .into(_db.settings)
        .insertOnConflictUpdate(
          SettingsCompanion.insert(key: key, value: value),
        );
  }

  /// The user's preferred display/entry unit. Defaults to kg.
  Future<WeightUnit> getUnit() async {
    final value = await _read(SettingsKeys.unit);
    return value == 'lb' ? WeightUnit.lb : WeightUnit.kg;
  }

  Future<void> setUnit(WeightUnit unit) {
    return _write(SettingsKeys.unit, unit == WeightUnit.lb ? 'lb' : 'kg');
  }

  /// Whether the daily weigh-in reminder is enabled. Defaults to false (W-5).
  Future<bool> getReminderEnabled() async {
    final value = await _read(SettingsKeys.reminderEnabled);
    return value == 'true';
  }

  Future<void> setReminderEnabled(bool enabled) {
    return _write(SettingsKeys.reminderEnabled, enabled.toString());
  }

  /// The user-chosen reminder time, or null if never set.
  Future<ReminderTime?> getReminderTime() async {
    final value = await _read(SettingsKeys.reminderTime);
    if (value == null) return null;
    return ReminderTime.parse(value);
  }

  Future<void> setReminderTime(ReminderTime time) {
    return _write(SettingsKeys.reminderTime, time.format());
  }
}
