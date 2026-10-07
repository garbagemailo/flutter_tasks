import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_cubit.dart';

class ThemeToggleAction extends StatelessWidget {
  const ThemeToggleAction({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select(
      (ThemeCubit cubit) => cubit.state == ThemeMode.dark,
    );
    return IconButton(
      key: const ValueKey('themeToggle'),
      tooltip: isDark ? 'Включить светлую тему' : 'Включить тёмную тему',
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
      onPressed: context.read<ThemeCubit>().toggleTheme,
    );
  }
}
