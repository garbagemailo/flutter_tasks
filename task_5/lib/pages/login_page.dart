import 'package:flutter/material.dart';
import '../account.dart';
import '../widgets/account_form.dart';
import 'data_formats_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Форматы данных')),
    body: FormLayout(children: [
      const SizedBox(height: 36),
      const Text('Добро пожаловать!\nВойдите в свой аккаунт\n'
          'Или создайте новый', style: TextStyle(fontSize: 20)),
      const SizedBox(height: 32),
      AccountForm(login: true, button: 'Войти',
        onSubmit: (_, email, password) {
          if (!Session.matches(email, password)) {
            return 'Неверный email или пароль. Сначала зарегистрируйтесь.';
          }
          Navigator.pushReplacement(context, MaterialPageRoute<void>(
            builder: (_) => const DataFormatsPage()));
          return null;
        },
        extra: Align(alignment: Alignment.centerRight,
          child: TextButton(child: const Text('Забыли пароль?'),
            onPressed: () => showDialog<void>(context: context,
              builder: (context) => AlertDialog(
                title: const Text('Учебный режим'),
                content: const Text('Восстановление по email не подключено. '
                    'Можно создать новую локальную учётную запись.'),
                actions: [TextButton(onPressed: () => Navigator.pop(context),
                    child: const Text('Понятно'))],
              )),
          )),
      ),
      const SizedBox(height: 36),
      TextButton(onPressed: () => Navigator.push(context,
        MaterialPageRoute<void>(builder: (_) => const RegisterPage())),
        child: const Text('Нет аккаунта? Зарегистрируйтесь')),
      const Text('Учебный режим: данные хранятся до закрытия приложения.',
        textAlign: TextAlign.center),
    ]),
  );
}
