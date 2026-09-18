import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../formats.dart';
import '../routes.dart';
import '../widgets/app_navigation.dart';
import '../widgets/format_header.dart';
import 'profile_page.dart';

const studentName = 'ЗАГЛУШКА';
const studentGroup = 'ЗАГЛУШКА';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.initialIndex = 0});
  final int initialIndex;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _index = widget.initialIndex;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(_index == 0 ? 'Форматы данных' : 'Профиль',
      style: const TextStyle(fontFamily: 'FormatTitle', fontSize: 22,
        fontWeight: FontWeight.w700))),
    body: IndexedStack(index: _index, children: [
      HomeContent(onDetail: (format) async {
        final index = await Navigator.pushNamed<int>(context,
          Routes.detail, arguments: format);
        if (mounted && index != null) setState(() => _index = index);
      }),
      const ProfilePage(embedded: true),
    ]),
    bottomNavigationBar: AppNavigation(index: _index,
      onSelect: (index) {
        FocusScope.of(context).unfocus();
        setState(() => _index = index);
      }),
  );
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.onDetail});
  final ValueChanged<DataFormat> onDetail;
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final desktop = kIsWeb || [TargetPlatform.linux,
      TargetPlatform.windows, TargetPlatform.macOS].contains(platform);
    final gap = desktop ? 28.0 : 16.0;
    return LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth > 600;
      final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
      Widget card(DataFormat format) => Card(
        margin: EdgeInsets.zero, clipBehavior: Clip.antiAlias,
        child: ListTile(key: ValueKey('card_${format.file}'),
          contentPadding: EdgeInsets.symmetric(horizontal: 16,
            vertical: wide ? 20 : 12),
          leading: Icon(format.icon, color: const Color(0xFF537A28)),
          title: Text(format.name), subtitle: Text(format.description),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onDetail(format)),
      );
      return SafeArea(child: SingleChildScrollView(
        key: const PageStorageKey('homeScroll'),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: gap),
        child: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormatHeader(spacing: gap),
              SizedBox(height: gap),
              if (wide) GridView.builder(
                key: const ValueKey('formatGrid'),
                shrinkWrap: true, primary: false,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 16,
                  mainAxisSpacing: gap, mainAxisExtent: 220 * scale),
                itemCount: formats.length,
                itemBuilder: (_, i) => card(formats[i]),
              ) else ListView.separated(
                key: const ValueKey('formatList'),
                shrinkWrap: true, primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: formats.length,
                separatorBuilder: (_, _) => SizedBox(height: gap),
                itemBuilder: (_, i) => card(formats[i]),
              ),
              SizedBox(height: gap),
              const Row(children: [Icon(Icons.person_outline),
                SizedBox(width: 12),
                Expanded(child: Text('$studentName\n$studentGroup'))]),
            ],
          ),
        )),
      ));
    });
  }
}
