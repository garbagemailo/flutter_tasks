import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';

const studentName = 'ЗАГЛУШКА';
const studentGroup = 'ЗАГЛУШКА';

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
      home: const DataFormatsPage(),
    );
  }
}

class DataFormat {
  const DataFormat(
    this.name, this.file, this.description, this.icon,
  );

  final String name;
  final String file;
  final String description;
  final IconData icon;
}

const formats = [
  DataFormat('JSON', 'json',
      'Объекты и массивы для обмена данными.', Icons.data_object),
  DataFormat('XML', 'xml',
      'Структурированные документы с тегами.', Icons.code),
  DataFormat('CSV', 'csv',
      'Табличные данные с разделителями.', Icons.table_chart),
  DataFormat('YAML', 'yaml',
      'Настройки с вложенностью на основе отступов.',
      Icons.settings),
  DataFormat('TOML', 'toml',
      'Файлы конфигурации с ключами и секциями.',
      Icons.description),
];

class DataFormatsPage extends StatelessWidget {
  const DataFormatsPage({super.key});

  void _showFormat(BuildContext context, DataFormat format) {
    final messenger = ScaffoldMessenger.of(context);
    // Последний выбор сразу заменяет предыдущее уведомление.
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Выбран формат: ${format.name}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Форматы данных',
          style: TextStyle(
            fontFamily: 'FormatTitle',
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB5EF55),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView.separated(
              key: const PageStorageKey('verticalList'),
              padding: const EdgeInsets.all(20),
              itemCount: formats.length + 2,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == 0) return const FormatHeader();
                if (index == formats.length + 1) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '$studentName\n$studentGroup',
                          ),
                        ),
                      ],
                    ),
                  );
                }
                final format = formats[index - 1];
                return Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    key: ValueKey('card_${format.file}'),
                    contentPadding: const EdgeInsets.all(16),
                    leading: Icon(
                      format.icon,
                      color: const Color(0xFF537A28),
                    ),
                    title: Text(format.name),
                    subtitle: Text(format.description),
                    trailing: const Icon(Icons.info_outline),
                    onTap: () => _showFormat(context, format),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FormatHeader extends StatelessWidget {
  const FormatHeader({super.key});

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
        const SizedBox(height: 16),
        const Text(
          'Формат данных определяет правила записи, хранения '
          'и обмена информацией. Он задаёт структуру данных '
          'и способ их представления.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 20),
        const Text(
          'Выберите формат',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
