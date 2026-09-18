import 'package:flutter/material.dart';

const studentName = 'ЗАГЛУШКА';
const studentGroup = 'ЗАГЛУШКА';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Форматы данных',
      debugShowCheckedModeBanner: false,
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
  const DataFormat(this.name, this.file, this.description);

  final String name;
  final String file;
  final String description;
}

const formats = [
  DataFormat('JSON', 'json', 'Объекты и массивы'),
  DataFormat('XML', 'xml', 'Разметка с тегами'),
  DataFormat('CSV', 'csv', 'Табличные данные'),
  DataFormat('YAML', 'yaml', 'Настройки и конфигурации'),
  DataFormat('TOML', 'toml', 'Конфигурации с секциями'),
];

class DataFormatsPage extends StatefulWidget {
  const DataFormatsPage({super.key});

  @override
  State<DataFormatsPage> createState() =>
      _DataFormatsPageState();
}

class _DataFormatsPageState extends State<DataFormatsPage> {
  int _currentIndex = 0;

  // Оба способа переключения используют одно состояние.
  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % formats.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = formats[_currentIndex];
    final status =
        '${_currentIndex + 1} / ${formats.length} — ${current.name}';

    final gallery = InfoPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              key: const Key('formatImage'),
              onTap: _nextImage,
              child: Image.asset(
                'assets/images/${current.file}.png',
                fit: BoxFit.contain,
                semanticLabel:
                    '${current.name}. Следующее изображение',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            status,
            key: const Key('imageCounter'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Нажмите на картинку или кнопку',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            key: const Key('nextImageButton'),
            onPressed: _nextImage,
            child: const Text('Следующее изображение'),
          ),
        ],
      ),
    );

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
        foregroundColor: const Color(0xFF20310F),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const InfoPanel(
                    child: Text(
                      'Форматы представления данных',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'FormatTitle',
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const InfoPanel(
                    child: Text(
                      'Формат данных определяет правила записи, '
                      'хранения и обмена информацией. Он задаёт '
                      'структуру данных и способ их представления, '
                      'чтобы программы могли читать и обрабатывать '
                      'информацию.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final stacked = constraints.maxWidth < 440 ||
                          MediaQuery.textScalerOf(context)
                                  .scale(16) >
                              24;
                      const list = InfoPanel(child: FormatsList());
                      if (stacked) {
                        return Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            gallery,
                            const SizedBox(height: 16),
                            list,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: gallery),
                          const SizedBox(width: 16),
                          const Expanded(child: list),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.person_outline, size: 36),
                      SizedBox(width: 16),
                      Expanded(
                        child: InfoPanel(
                          child: Text(
                            '$studentName\n$studentGroup',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFBFCCB0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class FormatsList extends StatelessWidget {
  const FormatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Примеры',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        for (var i = 0; i < formats.length; i++) ...[
          const SizedBox(height: 16),
          Text(
            '${i + 1}. ${formats[i].name}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(formats[i].description),
        ],
      ],
    );
  }
}
