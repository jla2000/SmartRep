import 'package:flutter_test/flutter_test.dart';
import 'package:smartrep/domain/units.dart';

void main() {
  group('roundToCanonicalKg', () {
    test('rounds down within half a tick', () {
      expect(roundToCanonicalKg(80.01), 80.0);
    });

    test('rounds up within half a tick', () {
      expect(roundToCanonicalKg(80.04), 80.05);
    });

    test('rounds exact ties away from zero', () {
      expect(roundToCanonicalKg(79.975), 80.0);
      expect(roundToCanonicalKg(79.925), 79.95);
    });

    test('already-canonical values are unchanged', () {
      expect(roundToCanonicalKg(62.35), 62.35);
      expect(roundToCanonicalKg(20.0), 20.0);
      expect(roundToCanonicalKg(350.0), 350.0);
    });
  });

  group('conversion', () {
    test('1 lb is exactly 0.45359237 kg', () {
      expect(lbToKg(1.0), closeTo(0.45359237, 1e-12));
    });

    test('kg <-> lb round trip', () {
      expect(kgToLb(lbToKg(150.0)), closeTo(150.0, 1e-9));
    });
  });

  group('parseToCanonicalKg', () {
    // SPEC §5.2 worked example: entering 176.4 lb displays as 80.0 kg.
    test('176.4 lb parses to canonical 80.0 kg', () {
      expect(parseToCanonicalKg(176.4, WeightUnit.lb), 80.0);
    });

    test('kg input is rounded to canonical precision, not converted', () {
      expect(parseToCanonicalKg(80.017, WeightUnit.kg), 80.0);
    });
  });

  group('formatWeight', () {
    test('kg is shown with 1 decimal', () {
      expect(formatWeight(80.06, WeightUnit.kg), '80.1');
      expect(formatWeight(80.0, WeightUnit.kg), '80.0');
    });

    test('lb is shown with 1 decimal', () {
      // 80.0 kg -> 176.37 lb -> "176.4"
      expect(formatWeight(80.0, WeightUnit.lb), '176.4');
    });
  });
}
