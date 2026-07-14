// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WeightEntriesTable extends WeightEntries
    with TableInfo<$WeightEntriesTable, WeightEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [date, weightKg, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  WeightEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightEntry(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $WeightEntriesTable createAlias(String alias) {
    return $WeightEntriesTable(attachedDatabase, alias);
  }
}

class WeightEntry extends DataClass implements Insertable<WeightEntry> {
  final String date;
  final double weightKg;
  final String? note;
  const WeightEntry({required this.date, required this.weightKg, this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  WeightEntriesCompanion toCompanion(bool nullToAbsent) {
    return WeightEntriesCompanion(
      date: Value(date),
      weightKg: Value(weightKg),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory WeightEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightEntry(
      date: serializer.fromJson<String>(json['date']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'weightKg': serializer.toJson<double>(weightKg),
      'note': serializer.toJson<String?>(note),
    };
  }

  WeightEntry copyWith({
    String? date,
    double? weightKg,
    Value<String?> note = const Value.absent(),
  }) => WeightEntry(
    date: date ?? this.date,
    weightKg: weightKg ?? this.weightKg,
    note: note.present ? note.value : this.note,
  );
  WeightEntry copyWithCompanion(WeightEntriesCompanion data) {
    return WeightEntry(
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntry(')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, weightKg, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightEntry &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.note == this.note);
}

class WeightEntriesCompanion extends UpdateCompanion<WeightEntry> {
  final Value<String> date;
  final Value<double> weightKg;
  final Value<String?> note;
  final Value<int> rowid;
  const WeightEntriesCompanion({
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeightEntriesCompanion.insert({
    required String date,
    required double weightKg,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       weightKg = Value(weightKg);
  static Insertable<WeightEntry> custom({
    Expression<String>? date,
    Expression<double>? weightKg,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeightEntriesCompanion copyWith({
    Value<String>? date,
    Value<double>? weightKg,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return WeightEntriesCompanion(
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntriesCompanion(')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetRateKgPerWeekMeta =
      const VerificationMeta('targetRateKgPerWeek');
  @override
  late final GeneratedColumn<double> targetRateKgPerWeek =
      GeneratedColumn<double>(
        'target_rate_kg_per_week',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _targetKcalDeltaMeta = const VerificationMeta(
    'targetKcalDelta',
  );
  @override
  late final GeneratedColumn<double> targetKcalDelta = GeneratedColumn<double>(
    'target_kcal_delta',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetWeightKgMeta = const VerificationMeta(
    'targetWeightKg',
  );
  @override
  late final GeneratedColumn<double> targetWeightKg = GeneratedColumn<double>(
    'target_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mode,
    targetRateKgPerWeek,
    targetKcalDelta,
    targetWeightKg,
    startDate,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('target_rate_kg_per_week')) {
      context.handle(
        _targetRateKgPerWeekMeta,
        targetRateKgPerWeek.isAcceptableOrUnknown(
          data['target_rate_kg_per_week']!,
          _targetRateKgPerWeekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetRateKgPerWeekMeta);
    }
    if (data.containsKey('target_kcal_delta')) {
      context.handle(
        _targetKcalDeltaMeta,
        targetKcalDelta.isAcceptableOrUnknown(
          data['target_kcal_delta']!,
          _targetKcalDeltaMeta,
        ),
      );
    }
    if (data.containsKey('target_weight_kg')) {
      context.handle(
        _targetWeightKgMeta,
        targetWeightKg.isAcceptableOrUnknown(
          data['target_weight_kg']!,
          _targetWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      targetRateKgPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_rate_kg_per_week'],
      )!,
      targetKcalDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_kcal_delta'],
      ),
      targetWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_weight_kg'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final String mode;
  final double targetRateKgPerWeek;
  final double? targetKcalDelta;
  final double? targetWeightKg;
  final String startDate;
  final bool active;
  const Goal({
    required this.id,
    required this.mode,
    required this.targetRateKgPerWeek,
    this.targetKcalDelta,
    this.targetWeightKg,
    required this.startDate,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mode'] = Variable<String>(mode);
    map['target_rate_kg_per_week'] = Variable<double>(targetRateKgPerWeek);
    if (!nullToAbsent || targetKcalDelta != null) {
      map['target_kcal_delta'] = Variable<double>(targetKcalDelta);
    }
    if (!nullToAbsent || targetWeightKg != null) {
      map['target_weight_kg'] = Variable<double>(targetWeightKg);
    }
    map['start_date'] = Variable<String>(startDate);
    map['active'] = Variable<bool>(active);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      mode: Value(mode),
      targetRateKgPerWeek: Value(targetRateKgPerWeek),
      targetKcalDelta: targetKcalDelta == null && nullToAbsent
          ? const Value.absent()
          : Value(targetKcalDelta),
      targetWeightKg: targetWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(targetWeightKg),
      startDate: Value(startDate),
      active: Value(active),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      mode: serializer.fromJson<String>(json['mode']),
      targetRateKgPerWeek: serializer.fromJson<double>(
        json['targetRateKgPerWeek'],
      ),
      targetKcalDelta: serializer.fromJson<double?>(json['targetKcalDelta']),
      targetWeightKg: serializer.fromJson<double?>(json['targetWeightKg']),
      startDate: serializer.fromJson<String>(json['startDate']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mode': serializer.toJson<String>(mode),
      'targetRateKgPerWeek': serializer.toJson<double>(targetRateKgPerWeek),
      'targetKcalDelta': serializer.toJson<double?>(targetKcalDelta),
      'targetWeightKg': serializer.toJson<double?>(targetWeightKg),
      'startDate': serializer.toJson<String>(startDate),
      'active': serializer.toJson<bool>(active),
    };
  }

  Goal copyWith({
    int? id,
    String? mode,
    double? targetRateKgPerWeek,
    Value<double?> targetKcalDelta = const Value.absent(),
    Value<double?> targetWeightKg = const Value.absent(),
    String? startDate,
    bool? active,
  }) => Goal(
    id: id ?? this.id,
    mode: mode ?? this.mode,
    targetRateKgPerWeek: targetRateKgPerWeek ?? this.targetRateKgPerWeek,
    targetKcalDelta: targetKcalDelta.present
        ? targetKcalDelta.value
        : this.targetKcalDelta,
    targetWeightKg: targetWeightKg.present
        ? targetWeightKg.value
        : this.targetWeightKg,
    startDate: startDate ?? this.startDate,
    active: active ?? this.active,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      mode: data.mode.present ? data.mode.value : this.mode,
      targetRateKgPerWeek: data.targetRateKgPerWeek.present
          ? data.targetRateKgPerWeek.value
          : this.targetRateKgPerWeek,
      targetKcalDelta: data.targetKcalDelta.present
          ? data.targetKcalDelta.value
          : this.targetKcalDelta,
      targetWeightKg: data.targetWeightKg.present
          ? data.targetWeightKg.value
          : this.targetWeightKg,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('targetRateKgPerWeek: $targetRateKgPerWeek, ')
          ..write('targetKcalDelta: $targetKcalDelta, ')
          ..write('targetWeightKg: $targetWeightKg, ')
          ..write('startDate: $startDate, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mode,
    targetRateKgPerWeek,
    targetKcalDelta,
    targetWeightKg,
    startDate,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.mode == this.mode &&
          other.targetRateKgPerWeek == this.targetRateKgPerWeek &&
          other.targetKcalDelta == this.targetKcalDelta &&
          other.targetWeightKg == this.targetWeightKg &&
          other.startDate == this.startDate &&
          other.active == this.active);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<String> mode;
  final Value<double> targetRateKgPerWeek;
  final Value<double?> targetKcalDelta;
  final Value<double?> targetWeightKg;
  final Value<String> startDate;
  final Value<bool> active;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.mode = const Value.absent(),
    this.targetRateKgPerWeek = const Value.absent(),
    this.targetKcalDelta = const Value.absent(),
    this.targetWeightKg = const Value.absent(),
    this.startDate = const Value.absent(),
    this.active = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required String mode,
    required double targetRateKgPerWeek,
    this.targetKcalDelta = const Value.absent(),
    this.targetWeightKg = const Value.absent(),
    required String startDate,
    this.active = const Value.absent(),
  }) : mode = Value(mode),
       targetRateKgPerWeek = Value(targetRateKgPerWeek),
       startDate = Value(startDate);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<String>? mode,
    Expression<double>? targetRateKgPerWeek,
    Expression<double>? targetKcalDelta,
    Expression<double>? targetWeightKg,
    Expression<String>? startDate,
    Expression<bool>? active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mode != null) 'mode': mode,
      if (targetRateKgPerWeek != null)
        'target_rate_kg_per_week': targetRateKgPerWeek,
      if (targetKcalDelta != null) 'target_kcal_delta': targetKcalDelta,
      if (targetWeightKg != null) 'target_weight_kg': targetWeightKg,
      if (startDate != null) 'start_date': startDate,
      if (active != null) 'active': active,
    });
  }

  GoalsCompanion copyWith({
    Value<int>? id,
    Value<String>? mode,
    Value<double>? targetRateKgPerWeek,
    Value<double?>? targetKcalDelta,
    Value<double?>? targetWeightKg,
    Value<String>? startDate,
    Value<bool>? active,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      targetRateKgPerWeek: targetRateKgPerWeek ?? this.targetRateKgPerWeek,
      targetKcalDelta: targetKcalDelta ?? this.targetKcalDelta,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      startDate: startDate ?? this.startDate,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (targetRateKgPerWeek.present) {
      map['target_rate_kg_per_week'] = Variable<double>(
        targetRateKgPerWeek.value,
      );
    }
    if (targetKcalDelta.present) {
      map['target_kcal_delta'] = Variable<double>(targetKcalDelta.value);
    }
    if (targetWeightKg.present) {
      map['target_weight_kg'] = Variable<double>(targetWeightKg.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('mode: $mode, ')
          ..write('targetRateKgPerWeek: $targetRateKgPerWeek, ')
          ..write('targetKcalDelta: $targetKcalDelta, ')
          ..write('targetWeightKg: $targetWeightKg, ')
          ..write('startDate: $startDate, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? key, String? value}) =>
      Setting(key: key ?? this.key, value: value ?? this.value);
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecommendationLogTable extends RecommendationLog
    with TableInfo<$RecommendationLogTable, RecommendationLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecommendationLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adjustmentKcalMeta = const VerificationMeta(
    'adjustmentKcal',
  );
  @override
  late final GeneratedColumn<double> adjustmentKcal = GeneratedColumn<double>(
    'adjustment_kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, status, adjustmentKcal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recommendation_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecommendationLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('adjustment_kcal')) {
      context.handle(
        _adjustmentKcalMeta,
        adjustmentKcal.isAcceptableOrUnknown(
          data['adjustment_kcal']!,
          _adjustmentKcalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecommendationLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecommendationLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      adjustmentKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}adjustment_kcal'],
      ),
    );
  }

  @override
  $RecommendationLogTable createAlias(String alias) {
    return $RecommendationLogTable(attachedDatabase, alias);
  }
}

class RecommendationLogData extends DataClass
    implements Insertable<RecommendationLogData> {
  final int id;
  final String date;
  final String status;
  final double? adjustmentKcal;
  const RecommendationLogData({
    required this.id,
    required this.date,
    required this.status,
    this.adjustmentKcal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || adjustmentKcal != null) {
      map['adjustment_kcal'] = Variable<double>(adjustmentKcal);
    }
    return map;
  }

  RecommendationLogCompanion toCompanion(bool nullToAbsent) {
    return RecommendationLogCompanion(
      id: Value(id),
      date: Value(date),
      status: Value(status),
      adjustmentKcal: adjustmentKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(adjustmentKcal),
    );
  }

  factory RecommendationLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecommendationLogData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      adjustmentKcal: serializer.fromJson<double?>(json['adjustmentKcal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(status),
      'adjustmentKcal': serializer.toJson<double?>(adjustmentKcal),
    };
  }

  RecommendationLogData copyWith({
    int? id,
    String? date,
    String? status,
    Value<double?> adjustmentKcal = const Value.absent(),
  }) => RecommendationLogData(
    id: id ?? this.id,
    date: date ?? this.date,
    status: status ?? this.status,
    adjustmentKcal: adjustmentKcal.present
        ? adjustmentKcal.value
        : this.adjustmentKcal,
  );
  RecommendationLogData copyWithCompanion(RecommendationLogCompanion data) {
    return RecommendationLogData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      adjustmentKcal: data.adjustmentKcal.present
          ? data.adjustmentKcal.value
          : this.adjustmentKcal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecommendationLogData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('adjustmentKcal: $adjustmentKcal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, status, adjustmentKcal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecommendationLogData &&
          other.id == this.id &&
          other.date == this.date &&
          other.status == this.status &&
          other.adjustmentKcal == this.adjustmentKcal);
}

class RecommendationLogCompanion
    extends UpdateCompanion<RecommendationLogData> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> status;
  final Value<double?> adjustmentKcal;
  const RecommendationLogCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.adjustmentKcal = const Value.absent(),
  });
  RecommendationLogCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String status,
    this.adjustmentKcal = const Value.absent(),
  }) : date = Value(date),
       status = Value(status);
  static Insertable<RecommendationLogData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? status,
    Expression<double>? adjustmentKcal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (adjustmentKcal != null) 'adjustment_kcal': adjustmentKcal,
    });
  }

  RecommendationLogCompanion copyWith({
    Value<int>? id,
    Value<String>? date,
    Value<String>? status,
    Value<double?>? adjustmentKcal,
  }) {
    return RecommendationLogCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      status: status ?? this.status,
      adjustmentKcal: adjustmentKcal ?? this.adjustmentKcal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (adjustmentKcal.present) {
      map['adjustment_kcal'] = Variable<double>(adjustmentKcal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecommendationLogCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('adjustmentKcal: $adjustmentKcal')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WeightEntriesTable weightEntries = $WeightEntriesTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $RecommendationLogTable recommendationLog =
      $RecommendationLogTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    weightEntries,
    goals,
    settings,
    recommendationLog,
  ];
}

typedef $$WeightEntriesTableCreateCompanionBuilder =
    WeightEntriesCompanion Function({
      required String date,
      required double weightKg,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$WeightEntriesTableUpdateCompanionBuilder =
    WeightEntriesCompanion Function({
      Value<String> date,
      Value<double> weightKg,
      Value<String?> note,
      Value<int> rowid,
    });

class $$WeightEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeightEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeightEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$WeightEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightEntriesTable,
          WeightEntry,
          $$WeightEntriesTableFilterComposer,
          $$WeightEntriesTableOrderingComposer,
          $$WeightEntriesTableAnnotationComposer,
          $$WeightEntriesTableCreateCompanionBuilder,
          $$WeightEntriesTableUpdateCompanionBuilder,
          (
            WeightEntry,
            BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntry>,
          ),
          WeightEntry,
          PrefetchHooks Function()
        > {
  $$WeightEntriesTableTableManager(_$AppDatabase db, $WeightEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightEntriesCompanion(
                date: date,
                weightKg: weightKg,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                required double weightKg,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightEntriesCompanion.insert(
                date: date,
                weightKg: weightKg,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeightEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightEntriesTable,
      WeightEntry,
      $$WeightEntriesTableFilterComposer,
      $$WeightEntriesTableOrderingComposer,
      $$WeightEntriesTableAnnotationComposer,
      $$WeightEntriesTableCreateCompanionBuilder,
      $$WeightEntriesTableUpdateCompanionBuilder,
      (
        WeightEntry,
        BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntry>,
      ),
      WeightEntry,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      required String mode,
      required double targetRateKgPerWeek,
      Value<double?> targetKcalDelta,
      Value<double?> targetWeightKg,
      required String startDate,
      Value<bool> active,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      Value<String> mode,
      Value<double> targetRateKgPerWeek,
      Value<double?> targetKcalDelta,
      Value<double?> targetWeightKg,
      Value<String> startDate,
      Value<bool> active,
    });

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetRateKgPerWeek => $composableBuilder(
    column: $table.targetRateKgPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetKcalDelta => $composableBuilder(
    column: $table.targetKcalDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetWeightKg => $composableBuilder(
    column: $table.targetWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetRateKgPerWeek => $composableBuilder(
    column: $table.targetRateKgPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetKcalDelta => $composableBuilder(
    column: $table.targetKcalDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetWeightKg => $composableBuilder(
    column: $table.targetWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<double> get targetRateKgPerWeek => $composableBuilder(
    column: $table.targetRateKgPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetKcalDelta => $composableBuilder(
    column: $table.targetKcalDelta,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetWeightKg => $composableBuilder(
    column: $table.targetWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
          Goal,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<double> targetRateKgPerWeek = const Value.absent(),
                Value<double?> targetKcalDelta = const Value.absent(),
                Value<double?> targetWeightKg = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<bool> active = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                mode: mode,
                targetRateKgPerWeek: targetRateKgPerWeek,
                targetKcalDelta: targetKcalDelta,
                targetWeightKg: targetWeightKg,
                startDate: startDate,
                active: active,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String mode,
                required double targetRateKgPerWeek,
                Value<double?> targetKcalDelta = const Value.absent(),
                Value<double?> targetWeightKg = const Value.absent(),
                required String startDate,
                Value<bool> active = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                mode: mode,
                targetRateKgPerWeek: targetRateKgPerWeek,
                targetKcalDelta: targetKcalDelta,
                targetWeightKg: targetWeightKg,
                startDate: startDate,
                active: active,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
      Goal,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$RecommendationLogTableCreateCompanionBuilder =
    RecommendationLogCompanion Function({
      Value<int> id,
      required String date,
      required String status,
      Value<double?> adjustmentKcal,
    });
typedef $$RecommendationLogTableUpdateCompanionBuilder =
    RecommendationLogCompanion Function({
      Value<int> id,
      Value<String> date,
      Value<String> status,
      Value<double?> adjustmentKcal,
    });

class $$RecommendationLogTableFilterComposer
    extends Composer<_$AppDatabase, $RecommendationLogTable> {
  $$RecommendationLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get adjustmentKcal => $composableBuilder(
    column: $table.adjustmentKcal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecommendationLogTableOrderingComposer
    extends Composer<_$AppDatabase, $RecommendationLogTable> {
  $$RecommendationLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get adjustmentKcal => $composableBuilder(
    column: $table.adjustmentKcal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecommendationLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecommendationLogTable> {
  $$RecommendationLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get adjustmentKcal => $composableBuilder(
    column: $table.adjustmentKcal,
    builder: (column) => column,
  );
}

class $$RecommendationLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecommendationLogTable,
          RecommendationLogData,
          $$RecommendationLogTableFilterComposer,
          $$RecommendationLogTableOrderingComposer,
          $$RecommendationLogTableAnnotationComposer,
          $$RecommendationLogTableCreateCompanionBuilder,
          $$RecommendationLogTableUpdateCompanionBuilder,
          (
            RecommendationLogData,
            BaseReferences<
              _$AppDatabase,
              $RecommendationLogTable,
              RecommendationLogData
            >,
          ),
          RecommendationLogData,
          PrefetchHooks Function()
        > {
  $$RecommendationLogTableTableManager(
    _$AppDatabase db,
    $RecommendationLogTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecommendationLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecommendationLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecommendationLogTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> adjustmentKcal = const Value.absent(),
              }) => RecommendationLogCompanion(
                id: id,
                date: date,
                status: status,
                adjustmentKcal: adjustmentKcal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String date,
                required String status,
                Value<double?> adjustmentKcal = const Value.absent(),
              }) => RecommendationLogCompanion.insert(
                id: id,
                date: date,
                status: status,
                adjustmentKcal: adjustmentKcal,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecommendationLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecommendationLogTable,
      RecommendationLogData,
      $$RecommendationLogTableFilterComposer,
      $$RecommendationLogTableOrderingComposer,
      $$RecommendationLogTableAnnotationComposer,
      $$RecommendationLogTableCreateCompanionBuilder,
      $$RecommendationLogTableUpdateCompanionBuilder,
      (
        RecommendationLogData,
        BaseReferences<
          _$AppDatabase,
          $RecommendationLogTable,
          RecommendationLogData
        >,
      ),
      RecommendationLogData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WeightEntriesTableTableManager get weightEntries =>
      $$WeightEntriesTableTableManager(_db, _db.weightEntries);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$RecommendationLogTableTableManager get recommendationLog =>
      $$RecommendationLogTableTableManager(_db, _db.recommendationLog);
}
