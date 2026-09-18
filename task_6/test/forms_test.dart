import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/main.dart';
import 'package:task/account.dart';
import 'package:task/widgets/text_field.dart';

void main() {
  test('Валидация обязательности, имени, email и состава пароля', () {
    for (final type in InputFieldType.values) {
      for (final value in <String?>[null, '', '   ']) {
        expect(validateInput(type, value), isNotNull);
      }
    }
    expect(validateInput(InputFieldType.name, 'Пётр Ёлкин'), isNull);
    expect(validateInput(InputFieldType.name, 'Иван2'), isNotNull);
    expect(validateInput(InputFieldType.name, 'Иван-Пётр'), isNotNull);
    expect(validateInput(InputFieldType.email, 'a@b.ru'), isNull);
    for (final value in ['a@b', '@b.ru', 'a@.ru', 'a@@b.ru', 'a b@c.ru']) {
      expect(validateInput(InputFieldType.email, value), isNotNull);
    }
    for (final value in ['Abc1+', 'abcdef', '12345+', 'Abc123']) {
      expect(validateInput(InputFieldType.password, value), isNotNull);
    }
    for (final value in ['Abcd1+', 'Abcd1_', 'Abcd1-']) {
      expect(validateInput(InputFieldType.password, value), isNull);
    }
    expect(validateInput(InputFieldType.confirmation, 'Abcd1+',
        password: 'Abcd1+'), isNull);
    expect(validateInput(InputFieldType.confirmation, 'Abcd1-',
        password: 'Abcd1+'), isNotNull);
  });

  testWidgets('Регистрация, фокус, маска, профиль, повторный вход', (t) async {
    Session.account = null;
    Session.signedIn = false;
    await t.binding.setSurfaceSize(const Size(460, 1000));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await t.pumpWidget(const MyApp());
    await t.pump(const Duration(seconds: 4));
    await t.pumpAndSettle();
    await t.tap(find.text('Нет аккаунта? Зарегистрируйтесь'));
    await t.pumpAndSettle();
    Finder field(String name) => find.byKey(ValueKey(name));
    Future<void> enter(String name, String value) async {
      await t.ensureVisible(field(name));
      await t.enterText(field(name), value);
    }
    Future<void> submit() async {
      await t.ensureVisible(find.byKey(const ValueKey('submit')));
      await t.tap(find.byKey(const ValueKey('submit')));
      await t.pumpAndSettle();
    }
    await submit();
    expect(find.text('Поле не может быть пустым'), findsNWidgets(4));
    await enter('name', 'Иван Иванов');
    await t.testTextInput.receiveAction(TextInputAction.next);
    await t.pump();
    expect(t.widget<TextFormField>(field('email')).focusNode!.hasFocus, isTrue);
    await enter('email', 'ivan@example.com');
    await enter('password', 'Abcd1+');
    await enter('confirmation', 'Abcd1-');
    await submit();
    expect(find.text('Пароли не совпадают'), findsOneWidget);
    await enter('confirmation', 'Abcd1+');
    await t.tap(find.byTooltip('Показать пароль').first);
    await t.pump();
    final editable = find.descendant(of: field('password'),
        matching: find.byType(EditableText));
    expect(t.widget<EditableText>(editable).obscureText, isFalse);
    await submit();
    expect(Session.account?.name, 'Иван Иванов');
    await enter('email', 'ivan@example.com');
    await enter('password', 'Abcd1+');
    await submit();
    await t.tap(find.byType(NavigationDestination).at(1));
    await t.pumpAndSettle();
    await enter('name', 'Пётр Иванов');
    await enter('password', 'New123_');
    await enter('confirmation', 'New123_');
    await submit();
    expect(find.text('Профиль сохранён'), findsOneWidget);
    await t.ensureVisible(find.text('Выйти из аккаунта'));
    await t.tap(find.text('Выйти из аккаунта'));
    await t.pumpAndSettle();
    await enter('email', 'ivan@example.com');
    await enter('password', 'Abcd1+');
    await submit();
    expect(find.text('Неверный email или пароль. Сначала зарегистрируйтесь.'),
        findsOneWidget);
    await enter('password', 'New123_');
    await submit();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(Session.account?.name, 'Пётр Иванов');
    expect(t.takeException(), isNull);
  });
}
