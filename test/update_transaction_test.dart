import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_pbp/client/transaction_client.dart';
import 'package:hotel_pbp/view/transaction_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'update_transaction_test.mocks.dart';

@GenerateMocks([http.Client, TransactionClient])
void main() {
  testWidgets('Update Transaction', (widgetTester) async {
    final client = MockClient();
    final transactionClient = MockTransactionClient();

    when(client.get(Uri.parse('http://10.0.0.2:8000/api/hotel'),
            headers: {'Accept': 'application/json'}))
        .thenAnswer((_) async => http.Response(
            jsonEncode(<Map<String, dynamic>>[
              {
                "id": 1,
                "name": "Hotel 1",
                "description": "Deskripsi Hotel 1",
                "price": "1000000",
                "rating": "5",
                "jumlah": "10",
                "image": "assets/hotel1.jpg"
              },
            ]),
            200));

    when(transactionClient.fetchAllTesting())
        .thenAnswer((_) async => <Map<String, dynamic>>[
              {
                "id": 1,
                "name": "Hotel 1",
                "description": "Deskripsi Hotel 1",
                "price": "1000000",
                "rating": "5",
                "jumlah": "10",
                "image": "assets/hotel1.jpg"
              },
            ]);

    await widgetTester.pumpWidget(MaterialApp(
        home: TransactionScreen(
      transactionClient: transactionClient,
    )));

    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.text('Update'));

    await widgetTester.pumpAndSettle();

    final textFields = find.byType(TextField);

    expect(textFields, findsNWidgets(5));

    await widgetTester.enterText(textFields.at(0), 'Hotel 1 Updated');
    await widgetTester.enterText(textFields.at(1), 'Deskripsi Hotel 1 Updated');
    await widgetTester.enterText(textFields.at(2), '7');
    await widgetTester.enterText(textFields.at(3), '250000');
    await widgetTester.enterText(textFields.at(4), 'assets/hotel2.jpg');

    await widgetTester.tap(find.text('Save'));

    await widgetTester.pumpAndSettle();
  });
}
