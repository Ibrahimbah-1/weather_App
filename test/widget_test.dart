import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';

void main() {
  testWidgets('App loads and shows loading spinner', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Expect to find the CircularProgressIndicator while loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
