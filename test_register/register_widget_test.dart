import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hotel_pbp/view/register_view.dart';

void main() {
 testWidgets('Username should be required', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final usernameField = find.byType(TextFormField).first;
  final submitButton = find.byType(ElevatedButton);

  // Tap submit without entering username
  await tester.tap(submitButton);

  // Expect error message about missing username
  final snackBar = find.text('Username is Required');
  expect(snackBar, findsOneWidget);
});

testWidgets('Username should not be empty', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final usernameField = find.byType(TextFormField).first;

  // Enter username only with spaces
  await tester.enterText(usernameField, '  ');

  // Expect error message about empty username
  final snackBar = find.text('Username is Required');
  expect(snackBar, findsOneWidget);
});

testWidgets('Email should be required', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final emailField = find.byType(TextFormField).at(1);
  final submitButton = find.byType(ElevatedButton);

  // Tap submit without entering email
  await tester.tap(submitButton);

  // Expect error message about missing email
  final snackBar = find.text('Email Tidak Boleh Kosong');
  expect(snackBar, findsOneWidget);
});

testWidgets('Email should be in valid format', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final emailField = find.byType(TextFormField).at(1);

  // Enter invalid email format
  await tester.enterText(emailField, 'invalid_email');

  // Expect error message about invalid format
  final snackBar = find.text('Email harus menggunakan @');
  expect(snackBar, findsOneWidget);
});

testWidgets('Password should be required', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final passwordField = find.byType(TextFormField).at(2);
  final submitButton = find.byType(ElevatedButton);

  // Tap submit without entering password
  await tester.tap(submitButton);

  // Expect error message about missing password
  final snackBar = find.text('Password is Required');
  expect(snackBar, findsOneWidget);
});

testWidgets('Password should be at least 5 characters', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final passwordField = find.byType(TextFormField).at(2);

  // Enter password with less than 5 characters
  await tester.enterText(passwordField, '1234');

  // Expect error message about short password
  final snackBar = find.text('Password minimal 5 digit');
  expect(snackBar, findsOneWidget);
});

testWidgets('Phone number should be required', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final phoneField = find.byType(TextFormField).at(3);
  final submitButton = find.byType(ElevatedButton);

  // Tap submit without entering phone number
  await tester.tap(submitButton);

  // Expect error message about missing phone number
  final snackBar = find.text('Nomor telepon is required');
  expect(snackBar, findsOneWidget);
});

testWidgets('Phone number should be at least 10 characters', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final phoneField = find.byType(TextFormField).at(3);

  // Enter phone number with less than 10 characters
  await tester.enterText(phoneField, '1234567');

  // Expect error message about short phone number
  final snackBar = find.text('Nomor telepon minimal 10 digit');
  expect(snackBar, findsOneWidget);
});

testWidgets('Origin should be required', (WidgetTester tester) async {
  await tester.pumpWidget(RegisterView());

  final originField = find.byType(TextFormField).at(4);
  final submitButton = find.byType(ElevatedButton);

  // Tap submit without entering origin
});
}
