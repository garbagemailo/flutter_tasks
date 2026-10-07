import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../theme/theme_toggle_action.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/models/data_format.dart';
import 'home/bloc/home_bloc.dart';
import '../routes.dart';
import '../di/di.dart';
import '../widgets/app_navigation.dart';
import '../widgets/format_header.dart';
import 'profile_page.dart';

const studentName = String.fromEnvironment(
  'STUDENT_NAME',
  defaultValue: 'ФИО студента',
);
const studentGroup = String.fromEnvironment(
  'STUDENT_GROUP',
  defaultValue: 'Группа',
);

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.initialIndex = 0});
  final int initialIndex;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<HomeBloc>(),
    child: _HomeShell(initialIndex: initialIndex),
  );
}

class _HomeShell extends StatefulWidget {
  const _HomeShell({required this.initialIndex});
  final int initialIndex;
  @override
  State<_HomeShell> createState() => _HomePageState();
}

class _HomePageState extends State<_HomeShell> {
  late int _index = widget.initialIndex;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: const [ThemeToggleAction()],
      title: Text(
        _index == 0 ? 'Форматы данных' : 'Профиль',
        style: const TextStyle(
          fontFamily: 'FormatTitle',
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    body: IndexedStack(
      index: _index,
      children: [
        HomeStateView(
          onDetail: (format) async {
            final index = await Navigator.pushNamed<int>(
              context,
              Routes.detail,
              arguments: format,
            );
            if (mounted && index != null) setState(() => _index = index);
          },
        ),
        const ProfilePage(embedded: true),
      ],
    ),
    bottomNavigationBar: AppNavigation(
      index: _index,
      onSelect: (index) {
        FocusScope.of(context).unfocus();
        setState(() => _index = index);
      },
    ),
  );
}

class HomeStateView extends StatelessWidget {
  const HomeStateView({super.key, required this.onDetail});
  final ValueChanged<DataFormat> onDetail;
  @override
  Widget build(BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      void load() => context.read<HomeBloc>().add(const LoadFormats());
      switch (state) {
        case HomeInitial():
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Справочник форматов данных'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => load(),
                  child: const Text('Показать форматы'),
                ),
              ],
            ),
          );
        case HomeLoading():
          return const Center(
            child: CircularProgressIndicator(
              semanticsLabel: 'Загрузка форматов',
            ),
          );
        case HomeError(:final message):
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => load(),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            ),
          );
        case HomeLoaded(:final formats):
          if (formats.isEmpty) return const Center(child: Text('Список пуст'));
          return HomeContent(formats: formats, onDetail: onDetail);
      }
    },
  );
}

IconData formatIcon(String file) => switch (file) {
  'json' => Icons.data_object,
  'xml' => Icons.code,
  'csv' => Icons.table_chart,
  'yaml' => Icons.settings,
  _ => Icons.description,
};

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.onDetail, required this.formats});
  final List<DataFormat> formats;
  final ValueChanged<DataFormat> onDetail;
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final desktop =
        kIsWeb ||
        [
          TargetPlatform.linux,
          TargetPlatform.windows,
          TargetPlatform.macOS,
        ].contains(platform);
    final gap = desktop ? 28.0 : 16.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 600;
        final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
        Widget card(DataFormat format) => Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            key: ValueKey('card_${format.file}'),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: wide ? 20 : 12,
            ),
            leading: Icon(
              formatIcon(format.file),
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(format.name),
            subtitle: Text(format.description),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onDetail(format),
          ),
        );
        return SafeArea(
          child: SingleChildScrollView(
            key: const PageStorageKey('homeScroll'),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: gap),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormatHeader(spacing: gap, formats: formats),
                    SizedBox(height: gap),
                    if (wide)
                      GridView.builder(
                        key: const ValueKey('formatGrid'),
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: gap,
                          mainAxisExtent: 220 * scale,
                        ),
                        itemCount: formats.length,
                        itemBuilder: (_, i) => card(formats[i]),
                      )
                    else
                      ListView.separated(
                        key: const ValueKey('formatList'),
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: formats.length,
                        separatorBuilder: (_, _) => SizedBox(height: gap),
                        itemBuilder: (_, i) => card(formats[i]),
                      ),
                    SizedBox(height: gap),
                    const Row(
                      children: [
                        Icon(Icons.person_outline),
                        SizedBox(width: 12),
                        Expanded(child: Text('$studentName\n$studentGroup')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
