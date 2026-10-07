import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/theme/app_theme.dart';
import 'package:task/theme/theme_cubit.dart';

void main() {
  test('ThemeCubit: light → dark → light', () async {
    final cubit = ThemeCubit();
    addTearDown(cubit.close);
    expect(cubit.state, ThemeMode.light);
    final changes = expectLater(
      cubit.stream,
      emitsInOrder([ThemeMode.dark, ThemeMode.light]),
    );
    cubit.toggleTheme();
    expect(cubit.state, ThemeMode.dark);
    cubit.toggleTheme();
    expect(cubit.state, ThemeMode.light);
    await changes;
  });

  test('Кастомные темы меняют все обязательные цвета и стиль кнопки', () {
    final light = AppTheme.light;
    final dark = AppTheme.dark;
    expect(light.brightness, Brightness.light);
    expect(dark.brightness, Brightness.dark);
    expect(light.scaffoldBackgroundColor, isNot(dark.scaffoldBackgroundColor));
    expect(
      light.appBarTheme.backgroundColor,
      isNot(dark.appBarTheme.backgroundColor),
    );
    expect(
      light.appBarTheme.foregroundColor,
      isNot(dark.appBarTheme.foregroundColor),
    );
    expect(
      light.textTheme.bodyMedium!.color,
      isNot(dark.textTheme.bodyMedium!.color),
    );
    expect(light.cardTheme.color, isNot(dark.cardTheme.color));
    expect(light.iconTheme.color, isNot(dark.iconTheme.color));
    for (final theme in [light, dark]) {
      final style = theme.elevatedButtonTheme.style!;
      expect(style.backgroundColor!.resolve({}), theme.colorScheme.primary);
      expect(style.foregroundColor!.resolve({}), theme.colorScheme.onPrimary);
      expect(style.shape!.resolve({}), isA<RoundedRectangleBorder>());
      expect(theme.navigationBarTheme.backgroundColor, theme.cardTheme.color);
    }
  });
}
