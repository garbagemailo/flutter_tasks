import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/pages/data_formats_page.dart';

void main() {
  Future<void> openApp(WidgetTester tester, Size size) async {
    await tester.binding.setSurfaceSize(size);
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MaterialApp(home: DataFormatsPage()));
    await tester.pumpAndSettle();
  }

  testWidgets('Каждая карточка показывает своё название', (tester) async {
    await openApp(tester, const Size(1000, 1600));
    for (final format in formats) {
      final card = find.byKey(ValueKey('card_${format.file}'));
      await tester.ensureVisible(card);
      await tester.tap(card);
      await tester.pumpAndSettle();
      expect(find.text('Выбран формат: ${format.name}'), findsOneWidget);
    }
    // Новый выбор не оставляет очередь устаревших уведомлений.
    expect(find.text('Выбран формат: JSON'), findsNothing);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Галерея листается до последнего изображения', (tester) async {
    await openApp(tester, const Size(390, 844));
    final gallery = find.byKey(const PageStorageKey('horizontalGallery'));
    for (var i = 0; i < 4; i++) {
      await tester.drag(gallery, const Offset(-260, 0));
      await tester.pumpAndSettle();
    }
    expect(find.byKey(const ValueKey('image_toml')).hitTestable(),
        findsOneWidget);
    final clip = tester.widget<ClipRRect>(
      find.byKey(const ValueKey('image_toml')),
    );
    expect(clip.borderRadius, BorderRadius.circular(18));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Узкий экран прокручивается до последней карточки',
      (tester) async {
    await openApp(tester, const Size(320, 640));
    final list = find.byKey(const PageStorageKey('verticalList'));
    for (var i = 0; i < 5; i++) {
      await tester.drag(list, const Offset(0, -220));
      await tester.pumpAndSettle();
    }
    final card = find.byKey(const ValueKey('card_toml'));
    expect(card.hitTestable(), findsOneWidget);
    await tester.tap(card);
    await tester.pumpAndSettle();
    expect(find.text('Выбран формат: TOML'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
