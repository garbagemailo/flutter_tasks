import 'package:flutter/material.dart';

import '../theme/theme_toggle_action.dart';

import '../formats.dart';
import '../widgets/app_navigation.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.format});
  final DataFormat format;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: const [ThemeToggleAction()],
      title: Text(format.name),
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        format.imagePath,
                        semanticLabel: 'Пример ${format.name}',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  format.description,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  format.fullDescription,
                  style: const TextStyle(fontSize: 17, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    bottomNavigationBar: AppNavigation(
      index: 0,
      onSelect: (index) => Navigator.pop(context, index),
    ),
  );
}
