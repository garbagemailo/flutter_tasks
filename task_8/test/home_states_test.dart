import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/pages/home_page.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';

import 'home_bloc_test.dart' show ControlledRepository;

void main() {
  testWidgets('initial, loading, error, retry и пустой список', (t) async {
    final repo = ControlledRepository();
    await t.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => HomeBloc(repo),
          child: Scaffold(body: HomeStateView(onDetail: (_) {})),
        ),
      ),
    );
    await t.tap(find.text('Показать форматы'));
    await t.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    repo.pending.completeError(StateError('test error'));
    await t.pumpAndSettle();
    expect(find.text('Повторить'), findsOneWidget);
    repo.pending = Completer();
    await t.tap(find.text('Повторить'));
    await t.pump();
    repo.pending.complete([]);
    await t.pumpAndSettle();
    expect(find.text('Список пуст'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
}
