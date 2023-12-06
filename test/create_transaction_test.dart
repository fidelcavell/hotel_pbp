import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_pbp/event/input_hotel.dart';

void main() {
  testWidgets('Create Transaction', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
        home: InputHotel(
            id: null,
            assets: null,
            name: null,
            desc: null,
            rating: null,
            price: null,
            jumlah: null)));

    await widgetTester.pumpAndSettle();

    final textFields = find.byType(TextFormField);

    expect(textFields, findsNWidgets(5));

    await widgetTester.enterText(textFields.at(0), 'Room X');
    await widgetTester.enterText(textFields.at(1), 'Room X is a room');
    await widgetTester.enterText(textFields.at(2), '5');
    await widgetTester.enterText(textFields.at(3), '100000');
    await widgetTester.enterText(textFields.at(4), '10');

    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text('Save'));

    await widgetTester.pumpAndSettle();
  });
}
