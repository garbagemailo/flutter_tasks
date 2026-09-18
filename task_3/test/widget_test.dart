import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/main.dart';

void main() {
  for (final key in ['nextImageButton', 'formatImage']) {
    testWidgets('Полный цикл и повторный цикл: $key', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1000, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(const MyApp());
      for (var step = 0; step < 11; step++) {
        final index = step % formats.length;
        final counter = tester.widget<Text>(
          find.byKey(const Key('imageCounter')),
        );
        expect(counter.data, '${index + 1} / 5 — ${formats[index].name}');
        final image = tester.widget<Image>(find.byType(Image));
        expect(
          (image.image as AssetImage).assetName,
          'assets/images/${formats[index].file}.png',
        );
        expect(tester.takeException(), isNull);
        await tester.tap(find.byKey(Key(key)));
        await tester.pumpAndSettle();
      }
    });
  }

  testWidgets('Кнопка и картинка изменяют один индекс', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1000, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const Key('nextImageButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('formatImage')));
    await tester.pumpAndSettle();
    expect(find.text('3 / 5 — CSV'), findsOneWidget);
    final title = tester.widget<Text>(find.text('Форматы данных'));
    expect(title.style?.fontFamily, 'FormatTitle');
  });

  testWidgets('Узкий экран прокручивается без переполнения', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final button = find.byKey(const Key('nextImageButton'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();
    expect(find.text('2 / 5 — XML'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
