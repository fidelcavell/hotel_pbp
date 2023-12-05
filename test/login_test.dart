import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_pbp/client/user_client.dart';
import 'package:hotel_pbp/entity/user.dart';
import 'package:hotel_pbp/view/login_view.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_test.mocks.dart';

@GenerateMocks([UserClient])
void main() {
  testWidgets('Login succesfull', (widgetTester) async {
    final userClient = MockUserClient();
    when(userClient.fetchAll_T()).thenAnswer((_) async => [
          User(
              id: 1,
              username: 'admin',
              password: 'admin',
              email: 'admin@gmx.de',
              gender: "L",
              nomorTelepon: 1792,
              origin: 'Tambah Bayan 5'),
        ]);

    await widgetTester.pumpWidget(MaterialApp(
      home: LoginView(userClient: userClient),
    ));

    final textFields = find.byType(TextField);

    expect(textFields, findsNWidgets(2));

    await widgetTester.enterText(textFields.at(0), 'admin');

    await widgetTester.enterText(textFields.at(1), 'admin');

    await widgetTester.tap(find.text('Login'));
  });
}
