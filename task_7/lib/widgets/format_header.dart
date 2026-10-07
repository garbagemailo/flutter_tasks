import 'package:flutter/material.dart';
import '../formats.dart';

class FormatHeader extends StatelessWidget {
  const FormatHeader({super.key, this.spacing = 16});
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Форматы представления данных',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'FormatTitle',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        SizedBox(height: spacing),
        const Text(
          'Формат данных определяет правила записи, хранения '
          'и обмена информацией. Он задаёт структуру данных '
          'и способ их представления.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        SizedBox(height: spacing),
        SizedBox(
          height: 180,
          child: ListView.separated(
            key: const PageStorageKey('horizontalGallery'),
            primary: false,
            scrollDirection: Axis.horizontal,
            itemCount: formats.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final format = formats[index];
              return ClipRRect(
                key: ValueKey('image_${format.file}'),
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/${format.file}.png',
                  width: 240,
                  height: 180,
                  fit: BoxFit.cover,
                  semanticLabel: 'Пример формата ${format.name}',
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Листайте изображения влево и вправо',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: spacing),
        const Text(
          'Выберите формат',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
