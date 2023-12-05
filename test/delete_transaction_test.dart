import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_pbp/client/transaction_client.dart';
import 'package:hotel_pbp/view/transaction_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'delete_transaction_test.mocks.dart';

@GenerateMocks([http.Client, TransactionClient])
void main() {
  testWidgets('Delete Transaction', (widgetTester) async {
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

    await widgetTester.tap(find.text('Delete'));

    await widgetTester.pumpAndSettle();
  });
}
