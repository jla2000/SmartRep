import 'package:drift/drift.dart';

import 'database.dart';

/// Data access for [WeightEntries] (SPEC §2.1). One row exists per calendar
/// day (W-1); [upsert] both creates and edits an entry, since "edit" is just
/// overwriting the row for that date. Back-dating (W-8) is likewise just
/// [upsert] with a past date, and note support (W-7) is a plain field on the
/// row.
///
/// Overwrite *confirmation* is a UI concern: callers should check
/// [getByDate] (or [hasEntryOn]) before calling [upsert] to decide whether to
/// ask "this day already has an entry, overwrite?" (W-1).
class WeightEntryDao {
  WeightEntryDao(this._db);

  final AppDatabase _db;

  /// The entry for [date] ('YYYY-MM-DD'), or null if none exists yet.
  Future<WeightEntry?> getByDate(String date) {
    return (_db.select(
      _db.weightEntries,
    )..where((t) => t.date.equals(date))).getSingleOrNull();
  }

  /// Whether [date] already has an entry, for the "overwrite?" confirmation
  /// flow (W-1).
  Future<bool> hasEntryOn(String date) async => await getByDate(date) != null;

  /// The most recent entry strictly before [date], if any. Useful for W-4's
  /// "> 5% jump from the previous entry" typo check when back-dating.
  Future<WeightEntry?> getLatestBefore(String date) {
    return (_db.select(_db.weightEntries)
          ..where((t) => t.date.isSmallerThanValue(date))
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// The most recent entry overall, if any.
  Future<WeightEntry?> getLatest() {
    return (_db.select(_db.weightEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// All entries in ascending date order.
  Future<List<WeightEntry>> getAllSortedByDate() {
    return (_db.select(
      _db.weightEntries,
    )..orderBy([(t) => OrderingTerm.asc(t.date)])).get();
  }

  /// Reactive stream of all entries in ascending date order, so downstream
  /// derived values (trend, recommendation) can recompute immediately after
  /// any edit, insert, or delete (W-2).
  Stream<List<WeightEntry>> watchAllSortedByDate() {
    return (_db.select(
      _db.weightEntries,
    )..orderBy([(t) => OrderingTerm.asc(t.date)])).watch();
  }

  /// Inserts a new entry for [date], or overwrites the existing one (W-1,
  /// used for both edits and back-dated entries, W-2/W-8). [weightKg] must
  /// already be canonical, rounded kg (see `domain/units.dart`); this DAO
  /// does not validate range or unit conversion.
  Future<void> upsert({
    required String date,
    required double weightKg,
    String? note,
  }) {
    return _db
        .into(_db.weightEntries)
        .insertOnConflictUpdate(
          WeightEntriesCompanion.insert(
            date: date,
            weightKg: weightKg,
            note: Value(note),
          ),
        );
  }

  /// Deletes the entry for [date], if any (W-2).
  Future<int> deleteByDate(String date) {
    return (_db.delete(
      _db.weightEntries,
    )..where((t) => t.date.equals(date))).go();
  }
}
