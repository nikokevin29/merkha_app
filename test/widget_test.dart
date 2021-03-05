// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merkha_app/services/services.dart';
import 'package:merkha_app/main.dart';
import 'package:merkha_app/models/models.dart';
import 'package:http/http.dart' as http;

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('Testing Login', () async {
    //ApiReturnValue<User> result = await UserServices.signIn('nikokevin29@gmail.com', '123123');
    http.Client client;
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'login';

    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{'email': 'nikokevin29@gmail.com', 'password': '123123'}),
    );
    var data = jsonDecode(response.body);
    print(data['meta']['status'].toString());
    //expect(data['meta']['status'], 'successs');
  });
}
