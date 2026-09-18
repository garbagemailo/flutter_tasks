import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() => runApp(const MyApp());

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices =>
      {...super.dragDevices, PointerDeviceKind.mouse};
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Форматы данных',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF537A28),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAF5),
      ),
      home: const LoginPage(),
    );
  }
}

