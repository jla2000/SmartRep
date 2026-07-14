import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartrep/main.dart';

void main() {
  testWidgets('SmartRepApp renders the placeholder home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: SmartRepApp()));

    expect(find.text('SmartRep'), findsOneWidget);
    expect(find.text('SmartRep is under construction.'), findsOneWidget);
  });
}
