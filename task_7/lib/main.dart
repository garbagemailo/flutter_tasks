import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'account.dart';
import 'formats.dart';
import 'routes.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';

void main() => runApp(const MyApp());

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {...super.dragDevices, PointerDeviceKind.mouse};
}

Route<dynamic> buildRoute(RouteSettings settings) {
  final protected = [Routes.home, Routes.profile, Routes.detail]
      .contains(settings.name);
  if (protected && !Session.signedIn) {
    return MaterialPageRoute<void>(settings: settings,
      builder: (_) => const LoginPage());
  }
  final Widget page;
  switch (settings.name) {
    case Routes.loading:
      page = const LoadingPage();
    case Routes.login:
      page = const LoginPage();
    case Routes.register:
      page = const RegisterPage();
    case Routes.home:
      page = const HomePage();
    case Routes.profile:
      page = const HomePage(initialIndex: 1);
    case Routes.detail:
      final format = settings.arguments;
      if (format is DataFormat) {
        return MaterialPageRoute<int>(settings: settings,
          builder: (_) => DetailPage(format: format));
      }
      page = const Scaffold(body: Center(
        child: Text('Не указан формат для детализации')));
    default:
      page = const Scaffold(body: Center(child: Text('Страница не найдена')));
  }
  return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Форматы данных', debugShowCheckedModeBanner: false,
    scrollBehavior: const AppScrollBehavior(),
    theme: ThemeData(useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF537A28)),
      scaffoldBackgroundColor: const Color(0xFFF8FAF5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFB5EF55), centerTitle: true),
    ),
    initialRoute: Routes.loading,
    onGenerateRoute: buildRoute,
  );
}
