
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ppb_mod3_kel13/main.dart';
void main() {
  testWidgets('Country app displays its main navigation', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(const CountryApp());
    expect(find.text('Countries'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}