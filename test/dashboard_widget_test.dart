import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Should display the main image when dashboard is opened',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    },
  );

  testWidgets(
    'Should display the firstfeature when dashboard is opened',
    (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final firstFeature = find.byType(FeatureItem);
      expect(firstFeature, findsWidgets);
    },
  );
}
