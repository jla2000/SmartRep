import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartrep/data/database.dart';
import 'package:smartrep/data/weight_entry_dao.dart';

void main() {
  late AppDatabase db;
  late WeightEntryDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = WeightEntryDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('upsert inserts a new entry', () async {
    await dao.upsert(date: '2026-07-14', weightKg: 80.0, note: 'morning');

    final entry = await dao.getByDate('2026-07-14');
    expect(entry, isNotNull);
    expect(entry!.weightKg, 80.0);
    expect(entry.note, 'morning');
  });

  test(
    'one entry per calendar day: upsert overwrites the existing row (W-1)',
    () async {
      await dao.upsert(date: '2026-07-14', weightKg: 80.0);
      await dao.upsert(date: '2026-07-14', weightKg: 81.5, note: 'edited');

      final all = await dao.getAllSortedByDate();
      expect(all, hasLength(1));
      expect(all.single.weightKg, 81.5);
      expect(all.single.note, 'edited');
    },
  );

  test('upsert can clear a note by overwriting with null', () async {
    await dao.upsert(date: '2026-07-14', weightKg: 80.0, note: 'temp');
    await dao.upsert(date: '2026-07-14', weightKg: 80.0);

    final entry = await dao.getByDate('2026-07-14');
    expect(entry!.note, isNull);
  });

  test(
    'hasEntryOn detects an existing entry, for the overwrite-confirm flow',
    () async {
      expect(await dao.hasEntryOn('2026-07-14'), isFalse);
      await dao.upsert(date: '2026-07-14', weightKg: 80.0);
      expect(await dao.hasEntryOn('2026-07-14'), isTrue);
    },
  );

  test(
    'back-dating: inserting a past date works like any other date (W-8)',
    () async {
      await dao.upsert(date: '2026-01-01', weightKg: 79.0);

      final entry = await dao.getByDate('2026-01-01');
      expect(entry, isNotNull);
      expect(entry!.weightKg, 79.0);
    },
  );

  test('deleteByDate removes the entry (W-2)', () async {
    await dao.upsert(date: '2026-07-14', weightKg: 80.0);
    final deleted = await dao.deleteByDate('2026-07-14');

    expect(deleted, 1);
    expect(await dao.getByDate('2026-07-14'), isNull);
  });

  test('deleteByDate on a missing date is a no-op', () async {
    final deleted = await dao.deleteByDate('2026-07-14');
    expect(deleted, 0);
  });

  test('getAllSortedByDate returns entries in ascending date order', () async {
    await dao.upsert(date: '2026-07-16', weightKg: 80.0);
    await dao.upsert(date: '2026-07-14', weightKg: 79.5);
    await dao.upsert(date: '2026-07-15', weightKg: 79.8);

    final all = await dao.getAllSortedByDate();
    expect(all.map((e) => e.date).toList(), [
      '2026-07-14',
      '2026-07-15',
      '2026-07-16',
    ]);
  });

  test(
    'getLatestBefore returns the most recent entry strictly before a date',
    () async {
      await dao.upsert(date: '2026-07-10', weightKg: 79.0);
      await dao.upsert(date: '2026-07-12', weightKg: 79.4);

      final latest = await dao.getLatestBefore('2026-07-14');
      expect(latest!.date, '2026-07-12');
      expect(latest.weightKg, 79.4);
    },
  );

  test('getLatest returns the most recent entry overall', () async {
    await dao.upsert(date: '2026-07-10', weightKg: 79.0);
    await dao.upsert(date: '2026-07-14', weightKg: 80.0);
    await dao.upsert(date: '2026-07-12', weightKg: 79.4);

    final latest = await dao.getLatest();
    expect(latest!.date, '2026-07-14');
  });

  test(
    'watchAllSortedByDate emits immediately on insert, edit, and delete (W-2)',
    () async {
      final emissions = <List<String>>[];
      final sub = dao.watchAllSortedByDate().listen((entries) {
        emissions.add(entries.map((e) => e.date).toList());
      });
      addTearDown(sub.cancel);

      await pumpEventQueue();
      await dao.upsert(date: '2026-07-14', weightKg: 80.0);
      await pumpEventQueue();
      await dao.upsert(date: '2026-07-13', weightKg: 79.5);
      await pumpEventQueue();
      await dao.deleteByDate('2026-07-14');
      await pumpEventQueue();

      expect(emissions.last, ['2026-07-13']);
      expect(emissions.length, greaterThanOrEqualTo(4));
    },
  );
}
