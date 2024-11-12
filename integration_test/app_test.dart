import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:multithreaded_trading_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('checking the workability of our app', () {
    testWidgets('checking ui', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // expect(find.text('bitcoin.'), findsOneWidget);
       await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.text('bitcoin').at(1));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.text('W'));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.text('M'));
       await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.text('3M'));
       await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.text('6M'));
       await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 5));
      await tester.tap(find.text('Y'));
       await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 5));
    });
  });
}
