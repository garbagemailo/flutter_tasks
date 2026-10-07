import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/account.dart';
import 'package:task/di/di.dart';
import 'package:task/main.dart';
import 'package:task/pages/login_page.dart';
import 'package:task/pages/register_page.dart';
import 'package:task/theme/theme_cubit.dart';

import 'test_di.dart';

void main() {
  setUp(setupTestDI);
  tearDown(() => getIt.reset());

  testWidgets('Смена темы сохраняет форму, маршрут и общий экземпляр Cubit', (
    t,
  ) async {
    Session.account = null;
    Session.signedIn = false;
    await t.pumpWidget(const MyApp());
    await t.pump(const Duration(seconds: 4));
    await t.pumpAndSettle();
    final email = find.byKey(const ValueKey('email'));
    await t.enterText(email, 'student@example.com');
    final firstCubit = t.element(find.byType(LoginPage)).read<ThemeCubit>();
    expect(
      Theme.of(t.element(find.byType(LoginPage))).brightness,
      Brightness.light,
    );
    await t.tap(find.byTooltip('Включить тёмную тему'));
    await t.pumpAndSettle();
    expect(
      Theme.of(t.element(find.byType(LoginPage))).brightness,
      Brightness.dark,
    );
    expect(
      t.widget<TextFormField>(email).controller!.text,
      'student@example.com',
    );
    expect(
      t.element(find.byType(LoginPage)).read<ThemeCubit>(),
      same(firstCubit),
    );
    await t.ensureVisible(find.text('Нет аккаунта? Зарегистрируйтесь'));
    await t.tap(find.text('Нет аккаунта? Зарегистрируйтесь'));
    await t.pumpAndSettle();
    expect(
      Theme.of(t.element(find.byType(RegisterPage))).brightness,
      Brightness.dark,
    );
    expect(
      t.element(find.byType(RegisterPage)).read<ThemeCubit>(),
      same(firstCubit),
    );
    await t.tap(find.byTooltip('Включить светлую тему'));
    await t.pumpAndSettle();
    expect(
      Theme.of(t.element(find.byType(RegisterPage))).brightness,
      Brightness.light,
    );
    await t.pageBack();
    await t.pumpAndSettle();
    expect(
      Theme.of(t.element(find.byType(LoginPage))).brightness,
      Brightness.light,
    );
    expect(
      t.widget<TextFormField>(email).controller!.text,
      'student@example.com',
    );
    expect(t.takeException(), isNull);
  });
}
