import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';

void main() {
  testWidgets('App launches', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(Scaffold), findsOneWidget);
  });
}