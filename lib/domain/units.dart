/// Unit the user enters/views weight in (SPEC §2.1, W-3). This only affects
/// input parsing and display formatting; canonical storage is always kg.
enum WeightUnit { kg, lb }

/// Exact conversion factor mandated by SPEC W-3: 1 lb = 0.45359237 kg.
const double kgPerLb = 0.45359237;

/// Canonical storage precision (W-3): weights are stored in kg rounded to
/// the nearest 0.05 kg.
const double kgPrecision = 0.05;

/// 1 / [kgPrecision], kept as its own constant (rather than computed) so
/// [roundToCanonicalKg] rounds via division, which matches the double
/// literal a human would write (e.g. exactly `80.05`) far more often than
/// multiplying by 0.05 does, since 0.05 has no exact binary representation.
const double _ticksPerKg = 20.0;

double kgToLb(double kg) => kg / kgPerLb;

double lbToKg(double lb) => lb * kgPerLb;

/// Rounds [kg] to the nearest [kgPrecision] (0.05 kg).
///
/// Ties round away from zero, matching Dart's `num.round()` semantics (e.g.
/// 79.975 -> 80.0, not 79.95). Rounding is done on an integer "tick" count
/// (kg / 0.05) rather than on the raw double, so repeated conversions don't
/// compound floating-point error.
double roundToCanonicalKg(double kg) {
  final ticks = (kg * _ticksPerKg).round();
  return ticks / _ticksPerKg;
}

/// Converts a user-entered [value] in [unit] into canonical, rounded kg
/// suitable for storage (W-3).
double parseToCanonicalKg(double value, WeightUnit unit) {
  final kg = unit == WeightUnit.kg ? value : lbToKg(value);
  return roundToCanonicalKg(kg);
}

/// Formats canonical [kg] for display in [unit], to one decimal place.
String formatWeight(double kg, WeightUnit unit) {
  final value = unit == WeightUnit.kg ? kg : kgToLb(kg);
  return value.toStringAsFixed(1);
}
