import 'package:flutter/material.dart';
import '../account.dart';
import '../widgets/account_form.dart';
import '../routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Регистрация'), centerTitle: true),
    body: FormLayout(children: [
      const SizedBox(height: 24),
      AccountForm(button: 'Зарегистрироваться',
        onSubmit: (name, email, password) {
          Session.account = Account(name, email, password);
          Session.signedIn = false;
          Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) => false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Регистрация завершена. Войдите в аккаунт.')));
          return null;
        }),
      const SizedBox(height: 36),
      TextButton(onPressed: () => Navigator.pop(context),
        child: const Text('Уже есть аккаунт? Войдите')),
      const Text('Сохраняется одна учебная учётная запись. '
        'Новая регистрация заменяет предыдущую.'),
    ]),
  );
}
