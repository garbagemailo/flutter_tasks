import 'package:flutter/material.dart';
import '../account.dart';
import '../widgets/account_form.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _avatar = Session.account?.avatar ?? 'json';
  Future<void> _chooseAvatar() async {
    final value = await showDialog<String>(context: context,
      builder: (context) => SimpleDialog(title: const Text('Изображение профиля'),
        children: [for (final name in ['json', 'xml', 'csv', 'yaml', 'toml'])
          SimpleDialogOption(onPressed: () => Navigator.pop(context, name),
            child: Text(name.toUpperCase())),
        ],
      ));
    if (value != null && mounted) setState(() => _avatar = value);
  }

  @override
  Widget build(BuildContext context) {
    final user = Session.account;
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль'), centerTitle: true),
      body: user == null ? const Center(child: Text('Сначала войдите в аккаунт'))
        : FormLayout(children: [
          Center(child: SizedBox(width: 120, height: 120,
            child: Stack(fit: StackFit.expand, children: [
              ClipRRect(borderRadius: BorderRadius.circular(18),
                child: Image.asset('assets/images/$_avatar.png', fit: BoxFit.cover)),
              Center(child: IconButton.filled(
                tooltip: 'Изменить изображение', onPressed: _chooseAvatar,
                icon: const Icon(Icons.camera_alt_outlined))),
            ]),
          )),
          const SizedBox(height: 24),
          AccountForm(initial: user, button: 'Сохранить',
            onSubmit: (name, email, password) {
              user.name = name;
              user.email = email;
              user.password = password;
              user.avatar = _avatar;
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text('Профиль сохранён')));
              return null;
            }),
          const SizedBox(height: 16),
          const Text('Для сохранения введите пароль и его подтверждение. '
            'Назад — вернуться без сохранения изменений.'),
          TextButton(onPressed: () => Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute<void>(builder: (_) => const LoginPage()),
            (_) => false), child: const Text('Выйти из аккаунта')),
        ]),
    );
  }
}
