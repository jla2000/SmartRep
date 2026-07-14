/// Valid weigh-in range, in canonical kg (SPEC W-4).
const double minWeightKg = 20.0;
const double maxWeightKg = 350.0;

/// A jump of more than this fraction of the previous entry prompts a "was
/// this a typo?" confirmation rather than a rejection (W-4). Exactly 5 % is
/// still accepted without confirmation; only values strictly greater than
/// 5 % trigger it.
const double typoJumpFraction = 0.05;

/// Result of validating a candidate weigh-in against SPEC W-4. Never both a
/// rejection and a confirmation prompt: out-of-range values are rejected
/// outright regardless of the previous entry.
sealed class WeighInValidation {
  const WeighInValidation();
}

/// The value is within range and not a suspicious jump; save it directly.
class WeighInAccepted extends WeighInValidation {
  const WeighInAccepted();
}

/// The value is within range but differs from the previous entry by more
/// than [typoJumpFraction]; the UI should ask the user to confirm before
/// saving.
class WeighInNeedsConfirmation extends WeighInValidation {
  const WeighInNeedsConfirmation(this.reason);
  final String reason;
}

/// The value is outside [minWeightKg]..[maxWeightKg] and must not be saved.
class WeighInRejected extends WeighInValidation {
  const WeighInRejected(this.reason);
  final String reason;
}

/// Validates a candidate weigh-in of [weightKg] canonical kg, optionally
/// comparing it against [previousWeightKg] (the most recent existing entry,
/// if any) to detect likely typos (W-4).
WeighInValidation validateWeighIn(double weightKg, {double? previousWeightKg}) {
  if (weightKg < minWeightKg || weightKg > maxWeightKg) {
    return WeighInRejected(
      'Weight must be between $minWeightKg and $maxWeightKg kg.',
    );
  }

  if (previousWeightKg != null && previousWeightKg > 0) {
    final fraction = (weightKg - previousWeightKg).abs() / previousWeightKg;
    if (fraction > typoJumpFraction) {
      return const WeighInNeedsConfirmation(
        'This is more than 5% different from your last entry. Was this a typo?',
      );
    }
  }

  return const WeighInAccepted();
}
