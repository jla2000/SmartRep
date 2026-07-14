import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// One weight measurement per calendar day (W-1). [date] is the ISO-8601
/// local calendar day, e.g. '2026-07-14'; [weightKg] is always canonical kg
/// (W-3); [note] is an optional free-text annotation (W-7).
class WeightEntries extends Table {
  TextColumn get date => text()();
  RealColumn get weightKg => real()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {date};
}

/// A weight-change goal (§2.2). Exactly one row is active at a time (G-1);
/// [targetRateKgPerWeek] is the normalized quantity the recommendation
/// engine consumes, regardless of which [mode] the user entered the goal in.
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mode => text()();
  RealColumn get targetRateKgPerWeek => real()();
  RealColumn get targetKcalDelta => real().nullable()();
  RealColumn get targetWeightKg => real().nullable()();
  TextColumn get startDate => text()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
}

/// Freeform key/value app settings (unit, advice style, reminder time, ...).
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

/// A history of computed recommendations, kept so the pinned dashboard card
/// (R-1) survives restarts and past recommendations are auditable.
class RecommendationLog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get status => text()();
  RealColumn get adjustmentKcal => real().nullable()();
}

@DriftDatabase(tables: [WeightEntries, Goals, Settings, RecommendationLog])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// Opens (or creates) the on-device SQLite file used in production.
  AppDatabase.production() : this(driftDatabase(name: 'smartrep'));

  @override
  int get schemaVersion => 1;
}
