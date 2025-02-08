import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:movies_test/app/core/services/alerts_service.dart';

void main() {
  late AlertsService alertsService;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    alertsService = AlertsService();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('showErrorMessage calls Get.snackbar with correct parameters',
      (WidgetTester tester) async {
    const title = 'Error Title';
    const message = 'Error Message';

    await tester.pumpWidget(
      GetMaterialApp(
        home: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              alertsService.showErrorMessage(title, message);
            },
            child: const Text('Show Toast'),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 4));

    expect(find.text(title), findsOneWidget);
    expect(find.text(message), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
