import 'package:flutter/material.dart';

abstract final class AppTheme {
  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background = isDark
        ? const Color(0xFF12180F)
        : const Color(0xFFF8FAF5);
    final surface = isDark ? const Color(0xFF1C2518) : const Color(0xFFFFFFFF);
    final text = isDark ? const Color(0xFFE6EEDD) : const Color(0xFF1E2618);
    final primary = isDark ? const Color(0xFFB5EF55) : const Color(0xFF365F1D);
    final onPrimary = isDark
        ? const Color(0xFF1E300E)
        : const Color(0xFFFFFFFF);
    final appBar = isDark ? const Color(0xFF223219) : const Color(0xFFB5EF55);
    final container = isDark
        ? const Color(0xFF344C23)
        : const Color(0xFFD7F5B3);
    final scheme =
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF537A28),
          brightness: brightness,
        ).copyWith(
          primary: primary,
          onPrimary: onPrimary,
          primaryContainer: container,
          onPrimaryContainer: text,
          surface: surface,
          onSurface: text,
        );
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );
    return base.copyWith(
      scaffoldBackgroundColor: background,
      textTheme: base.textTheme
          .apply(bodyColor: text, displayColor: text)
          .copyWith(
            bodyMedium: base.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: text,
            ),
            titleMedium: base.textTheme.titleMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: text,
            ),
          ),
      appBarTheme: AppBarThemeData(
        backgroundColor: appBar,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: text),
        actionsIconTheme: IconThemeData(color: text),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      iconTheme: IconThemeData(color: primary),
      listTileTheme: ListTileThemeData(iconColor: primary, textColor: text),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          surfaceTintColor: Colors.transparent,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: buttonShape,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: container,
        surfaceTintColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? text : primary,
          ),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: text, fontSize: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
