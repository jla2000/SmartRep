import 'package:flutter_test/flutter_test.dart';
import 'package:smartrep/domain/weigh_in_validation.dart';

void main() {
  group('range (W-4)', () {
    test('accepts the boundary values', () {
      expect(validateWeighIn(20.0), isA<WeighInAccepted>());
      expect(validateWeighIn(350.0), isA<WeighInAccepted>());
    });

    test('rejects below the minimum', () {
      expect(validateWeighIn(19.99), isA<WeighInRejected>());
    });

    test('rejects above the maximum', () {
      expect(validateWeighIn(350.01), isA<WeighInRejected>());
    });
  });

  group('typo jump (W-4), 5% boundary', () {
    test('exactly 5% difference is accepted, not flagged', () {
      // 100 -> 105 is exactly a 5% jump.
      final result = validateWeighIn(105.0, previousWeightKg: 100.0);
      expect(result, isA<WeighInAccepted>());
    });

    test('just over 5% difference needs confirmation', () {
      final result = validateWeighIn(105.01, previousWeightKg: 100.0);
      expect(result, isA<WeighInNeedsConfirmation>());
    });

    test('a large decrease also needs confirmation', () {
      // 85.0 -> 58.0 is a ~32% drop (SPEC §5.2 backdated-edit example).
      final result = validateWeighIn(58.0, previousWeightKg: 85.0);
      expect(result, isA<WeighInNeedsConfirmation>());
    });

    test('small day-to-day noise is accepted', () {
      final result = validateWeighIn(80.5, previousWeightKg: 80.0);
      expect(result, isA<WeighInAccepted>());
    });

    test('no previous entry never needs confirmation', () {
      final result = validateWeighIn(200.0);
      expect(result, isA<WeighInAccepted>());
    });

    test(
      'out-of-range values are rejected even if close to the previous entry',
      () {
        final result = validateWeighIn(351.0, previousWeightKg: 350.0);
        expect(result, isA<WeighInRejected>());
      },
    );
  });
}
