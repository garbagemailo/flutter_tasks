import 'package:flutter/material.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key, required this.index, required this.onSelect});
  final int index;
  final ValueChanged<int> onSelect;
  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: index, onDestinationSelected: onSelect,
    backgroundColor: const Color(0xFFE1FFA8),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    destinations: const [
      NavigationDestination(icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home), label: 'Главная'),
      NavigationDestination(icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person), label: 'Профиль'),
    ],
  );
}
