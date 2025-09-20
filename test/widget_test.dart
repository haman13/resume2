// This is a basic Flutter widget test for the resume app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:resume/main.dart';

void main() {
  testWidgets('Resume app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame with a larger screen size
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    await tester.pumpWidget(const MyApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
