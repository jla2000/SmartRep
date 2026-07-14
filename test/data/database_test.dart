import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartrep/data/database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and read back a weight entry', () async {
    await db
        .into(db.weightEntries)
        .insert(
          WeightEntriesCompanion.insert(
            date: '2026-07-14',
            weightKg: 80.05,
            note: const Value('after vacation'),
          ),
        );

    final rows = await db.select(db.weightEntries).get();
    expect(rows, hasLength(1));
    expect(rows.single.date, '2026-07-14');
    expect(rows.single.weightKg, 80.05);
    expect(rows.single.note, 'after vacation');
  });

  test('insert and read back a goal', () async {
    final id = await db
        .into(db.goals)
        .insert(
          GoalsCompanion.insert(
            mode: 'rate',
            targetRateKgPerWeek: -0.23,
            startDate: '2026-07-01',
            targetKcalDelta: const Value(null),
            targetWeightKg: const Value(75.0),
          ),
        );

    final goal = await (db.select(
      db.goals,
    )..where((g) => g.id.equals(id))).getSingle();
    expect(goal.mode, 'rate');
    expect(goal.targetRateKgPerWeek, -0.23);
    expect(goal.startDate, '2026-07-01');
    expect(goal.targetWeightKg, 75.0);
    expect(goal.active, isTrue);
  });

  test('insert and read back a setting', () async {
    await db
        .into(db.settings)
        .insert(SettingsCompanion.insert(key: 'unit', value: 'kg'));

    final setting = await (db.select(
      db.settings,
    )..where((s) => s.key.equals('unit'))).getSingle();
    expect(setting.value, 'kg');
  });

  test('insert and read back a recommendation log row', () async {
    await db
        .into(db.recommendationLog)
        .insert(
          RecommendationLogCompanion.insert(
            date: '2026-07-14',
            status: 'eat_more',
            adjustmentKcal: const Value(300.0),
          ),
        );

    final rows = await db.select(db.recommendationLog).get();
    expect(rows, hasLength(1));
    expect(rows.single.date, '2026-07-14');
    expect(rows.single.status, 'eat_more');
    expect(rows.single.adjustmentKcal, 300.0);
  });
}
