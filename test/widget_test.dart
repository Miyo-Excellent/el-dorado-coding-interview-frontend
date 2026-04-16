import 'package:flutter_test/flutter_test.dart';

import 'package:el_dorado_coding_interview_frontend/main.dart';

void main() {
  testWidgets('ElDoradoApp renders without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ElDoradoApp());

    // Verify that the app renders (basic smoke test).
    expect(find.byType(ElDoradoApp), findsOneWidget);
  });
}
