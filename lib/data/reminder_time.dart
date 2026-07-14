/// A time-of-day (24h, no timezone) at which the daily weigh-in reminder
/// fires (W-5). Kept independent of `package:flutter/material.dart`'s
/// `TimeOfDay` so the data layer has no Flutter UI dependency.
class ReminderTime {
  const ReminderTime({required this.hour, required this.minute})
    : assert(hour >= 0 && hour <= 23, 'hour must be 0-23'),
      assert(minute >= 0 && minute <= 59, 'minute must be 0-59');

  final int hour;
  final int minute;

  /// Parses an `HH:mm` string as stored in the settings table.
  factory ReminderTime.parse(String value) {
    final parts = value.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid reminder time: $value');
    }
    return ReminderTime(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  /// Formats as `HH:mm` for storage.
  String format() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) =>
      other is ReminderTime && other.hour == hour && other.minute == minute;

  @override
  int get hashCode => Object.hash(hour, minute);

  @override
  String toString() => 'ReminderTime(${format()})';
}
