import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_pbp/view/register_view.dart';

void main() {
  testWidgets('Register test', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: RegisterView()));

    await widgetTester.pumpAndSettle();

    final textFields = find.byType(TextFormField);

    expect(textFields, findsNWidgets(5));

    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(textFields.at(0), 'pqrs74');
    await widgetTester.enterText(textFields.at(1), 'pqrs74@aol.fr');
    await widgetTester.enterText(textFields.at(2), 'pqrs74');
    await widgetTester.enterText(textFields.at(3), '082177821244');
    await widgetTester.enterText(textFields.at(4), 'Jl. Kaliurang KM 5');
    await widgetTester.tap(find.byKey(const Key('Perempuan')));
    await widgetTester.drag(find.byType(Scaffold), const Offset(0, -500));

    await widgetTester.pumpAndSettle();

    expect(find.text('Register'), findsOneWidget);

    await widgetTester.tap(find.text('Register'));

    await widgetTester.pumpAndSettle();
  });
}
