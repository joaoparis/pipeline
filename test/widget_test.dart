// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pipeline/presentation/widgets/pipeline_page_widget.dart';

void main() {
  testWidgets('Expansion panel expands when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PipelinePageWidget(),
      ),
    );

    await tester.tap(find.text('icebox 🧊'));
    await tester.pumpAndSettle();

    expect(find.text('Task 1'), findsOneWidget);
  });
}
