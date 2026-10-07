import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme/app_theme.dart';
import 'theme/theme_cubit.dart';

import 'account.dart';
import 'di/di.dart';
import 'formats.dart';
import 'routes.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(const MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => {
    ...super.dragDevices,
    PointerDeviceKind.mouse,
  };
}

Route<dynamic> buildRoute(RouteSettings settings) {
  final protected = [
    Routes.home,
    Routes.profile,
    Routes.detail,
  ].contains(settings.name);
  if (protected && !Session.signedIn) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => const LoginPage(),
    );
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
        return MaterialPageRoute<int>(
          settings: settings,
          builder: (_) => DetailPage(format: format),
        );
      }
      page = const Scaffold(
        body: Center(child: Text('Не указан формат для детализации')),
      );
    default:
      page = const Scaffold(body: Center(child: Text('Страница не найдена')));
  }
  return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<ThemeCubit>(),
    child: BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) => MaterialApp(
        title: 'Форматы данных',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const AppScrollBehavior(),
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: mode,
        initialRoute: Routes.loading,
        onGenerateRoute: buildRoute,
      ),
    ),
  );
}
