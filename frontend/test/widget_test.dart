import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('Frontend is running smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that "Frontend is running!" text is displayed.
    expect(find.text('Frontend is running!'), findsOneWidget);
  });
}
