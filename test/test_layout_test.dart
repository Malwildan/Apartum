import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Stack Column Expanded layout', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),
    ));
    expect(find.byType(Expanded), findsOneWidget);
  });
}
