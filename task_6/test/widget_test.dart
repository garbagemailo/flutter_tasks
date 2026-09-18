import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/account.dart';
import 'package:task/main.dart';
import 'package:task/routes.dart';
import 'package:task/pages/loading_page.dart';
import 'package:task/pages/login_page.dart';
import 'package:task/pages/home_page.dart';
import 'package:task/pages/detail_page.dart';

void main() {
  setUp(() {
    Session.account = Account('Иван Иванов', 'ivan@example.com', 'Abcd1+');
    Session.signedIn = true;
  });

  Future<void> home(WidgetTester t, double width,
      {TargetPlatform platform = TargetPlatform.android}) async {
    await t.binding.setSurfaceSize(Size(width, 1000));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await t.pumpWidget(MaterialApp(
      theme: ThemeData(platform: platform),
      home: const HomePage(), onGenerateRoute: buildRoute));
    await t.pumpAndSettle();
  }

  testWidgets('Заставка ровно 4 секунды и замена маршрута', (t) async {
    await t.pumpWidget(const MyApp());
    expect(find.byType(LoadingPage), findsOneWidget);
    await t.pump(const Duration(milliseconds: 3999));
    expect(find.byType(LoginPage), findsNothing);
    await t.pump(const Duration(milliseconds: 1));
    await t.pumpAndSettle();
    expect(find.byType(LoadingPage), findsNothing);
    expect(find.byType(LoginPage), findsOneWidget);
    expect(Navigator.canPop(t.element(find.byType(LoginPage))), isFalse);
  });

  for (final width in [600.0, 601.0, 1000.0]) {
    testWidgets('Граница сетки при ширине $width', (t) async {
      await home(t, width);
      if (width <= 600) {
        expect(find.byKey(const ValueKey('formatList')), findsOneWidget);
        expect(find.byType(GridView), findsNothing);
      } else {
        final grid = t.widget<GridView>(find.byType(GridView));
        final delegate = grid.gridDelegate
            as SliverGridDelegateWithFixedCrossAxisCount;
        expect(delegate.crossAxisCount, 2);
        final a = t.getTopLeft(find.byKey(const ValueKey('card_json')));
        final b = t.getTopLeft(find.byKey(const ValueKey('card_xml')));
        expect(a.dy, closeTo(b.dy, 1));
        expect(b.dx, greaterThan(a.dx));
      }
      expect(t.takeException(), isNull);
    });
  }

  testWidgets('Детализация, возврат и выбор профиля снизу', (t) async {
    await home(t, 390);
    final card = find.byKey(const ValueKey('card_json'));
    await t.ensureVisible(card);
    await t.tap(card);
    await t.pumpAndSettle();
    expect(find.byType(DetailPage), findsOneWidget);
    expect(find.text('JSON'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    await t.pageBack();
    await t.pumpAndSettle();
    expect(card.hitTestable(), findsOneWidget);
    await t.tap(card);
    await t.pumpAndSettle();
    await t.tap(find.byType(NavigationDestination).at(1));
    await t.pumpAndSettle();
    expect(find.byType(DetailPage), findsNothing);
    expect(find.text('Сохранить'), findsOneWidget);
    expect(t.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex, 1);
    await t.tap(find.byType(NavigationDestination).at(0));
    await t.pumpAndSettle();
    expect(card.hitTestable(), findsOneWidget);
    expect(t.takeException(), isNull);
  });

  testWidgets('На десктопе увеличен интервал между рядами', (t) async {
    await home(t, 1000, platform: TargetPlatform.linux);
    final grid = t.widget<GridView>(find.byType(GridView));
    final delegate = grid.gridDelegate
        as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.mainAxisSpacing, 28);
    expect(t.takeException(), isNull);
  });

  testWidgets('Без входа защищённый маршрут показывает авторизацию', (t) async {
    Session.signedIn = false;
    await t.pumpWidget(MaterialApp(onGenerateRoute: buildRoute));
    await t.pump(const Duration(seconds: 4));
    await t.pumpAndSettle();
    Navigator.pushNamed(t.element(find.byType(LoginPage)), Routes.home);
    await t.pumpAndSettle();
    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
