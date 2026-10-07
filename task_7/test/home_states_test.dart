import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/pages/home_page.dart';

void main() {
  testWidgets('HomePage: initial, loading, error, retry, loaded', (t) async {
    await t.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.text('Показать форматы'), findsOneWidget);
    await t.tap(find.text('Проверить ошибку загрузки'));
    await t.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await t.pump(const Duration(milliseconds: 500));
    await t.pump();
    expect(find.text('Повторить'), findsOneWidget);
    await t.tap(find.text('Повторить'));
    await t.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await t.pump(const Duration(milliseconds: 500));
    await t.pumpAndSettle();
    expect(find.byKey(const ValueKey('card_json')), findsOneWidget);
    expect(find.text('Повторить'), findsNothing);
    expect(t.takeException(), isNull);
  });
}
