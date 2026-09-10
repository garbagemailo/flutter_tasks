import 'package:flutter/material.dart';

const String studentName = 'ЗАГЛУШКА';
const String studentGroup = 'ЗАГЛУШКА';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Форматы данных',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF537A28)),
        scaffoldBackgroundColor: const Color(0xFFF8FAF5),
      ),
      home: const DataFormatsPage(),
    );
  }
}

class DataFormatsPage extends StatelessWidget {
  const DataFormatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Форматы данных'),
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
                    child: Center(
                      child: Text(
                        'Форматы представления данных',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const InfoPanel(
                    child: Text(
                      'Формат данных определяет правила записи, хранения '
                      'и обмена информацией. Он задаёт структуру данных '
                      'и способ их представления, чтобы разные программы '
                      'могли корректно читать и обрабатывать информацию.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 28),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final stacked = constraints.maxWidth < 300 ||
                          MediaQuery.textScalerOf(context).scale(16) > 24;
                      final picture = InfoPanel(
                        child: Image.asset(
                          'assets/images/data_formats.png',
                          fit: BoxFit.contain,
                          semanticLabel: 'Четыре формата: JSON, XML, CSV и YAML',
                        ),
                      );
                      const formats = InfoPanel(child: FormatsList());
                      if (stacked) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            picture,
                            const SizedBox(height: 16),
                            formats,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: picture),
                          const SizedBox(width: 16),
                          const Expanded(child: formats),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 28),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 40,
                        color: Color(0xFF537A28),
                        semanticLabel: 'Автор работы',
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: InfoPanel(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(studentName, style: TextStyle(fontSize: 16)),
                              SizedBox(height: 6),
                              Text(studentGroup),
                            ],
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
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}

class FormatsList extends StatelessWidget {
  const FormatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Примеры',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        FormatEntry(title: '1. JSON', description: 'Объекты и массивы'),
        SizedBox(height: 16),
        FormatEntry(title: '2. XML', description: 'Разметка с тегами'),
        SizedBox(height: 16),
        FormatEntry(title: '3. CSV', description: 'Табличные данные'),
        SizedBox(height: 16),
        FormatEntry(title: '4. YAML', description: 'Настройки и конфигурации'),
      ],
    );
  }
}

class FormatEntry extends StatelessWidget {
  const FormatEntry({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontSize: 14, height: 1.35)),
      ],
    );
  }
}
