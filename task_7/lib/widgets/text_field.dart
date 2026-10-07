import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmation }

String? validateInput(InputFieldType type, String? value,
    {String? password}) {
  if (value == null || value.trim().isEmpty) {
    return 'Поле не может быть пустым';
  }
  switch (type) {
    case InputFieldType.name:
      if (!RegExp(r'^[\p{L} ]+$', unicode: true).hasMatch(value)) {
        return 'Допустимы только буквы и пробелы';
      }
    case InputFieldType.email:
      if (!RegExp(r'^[^\s@]+@[^\s@.]+(?:\.[^\s@.]+)+$')
          .hasMatch(value.trim())) {
        return 'Введите email вида name@example.com';
      }
    case InputFieldType.password:
      if (value.runes.length < 6 ||
          !RegExp(r'\p{L}', unicode: true).hasMatch(value) ||
          !RegExp(r'[0-9]').hasMatch(value) ||
          !RegExp(r'[+_\-]').hasMatch(value)) {
        return 'Не менее 6 символов: буква, цифра и +, _ или -';
      }
    case InputFieldType.confirmation:
      if (value != password) return 'Пароли не совпадают';
  }
  return null;
}

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({super.key, required this.type,
    required this.controller, required this.focusNode,
    required this.onSubmitted, this.last = false,
    this.passwordController});
  final InputFieldType type;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final FocusNode focusNode;
  final VoidCallback onSubmitted;
  final bool last;

  @override
  State<CustomTextFormField> createState() => _FieldState();
}

class _FieldState extends State<CustomTextFormField> {
  bool _hidden = true;
  @override
  Widget build(BuildContext context) {
    final type = widget.type;
    final secret = type == InputFieldType.password ||
        type == InputFieldType.confirmation;
    final label = switch (type) {
      InputFieldType.name => 'ФИО',
      InputFieldType.email => 'Email',
      InputFieldType.password => 'Пароль',
      InputFieldType.confirmation => 'Повторите пароль',
    };
    return TextFormField(
      key: ValueKey(type.name),
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: secret && _hidden,
      enableSuggestions: !secret,
      autocorrect: !secret,
      keyboardType: type == InputFieldType.email
          ? TextInputType.emailAddress : TextInputType.text,
      textInputAction: widget.last
          ? TextInputAction.done : TextInputAction.next,
      onFieldSubmitted: (_) => widget.onSubmitted(),
      validator: (value) => validateInput(type, value,
          password: widget.passwordController?.text),
      decoration: InputDecoration(
        labelText: label,
        errorMaxLines: 3,
        prefixIcon: Icon(switch (type) {
          InputFieldType.name => Icons.person_outline,
          InputFieldType.email => Icons.email_outlined,
          _ => Icons.shield_outlined,
        }),
        suffixIcon: secret ? IconButton(
          tooltip: _hidden ? 'Показать пароль' : 'Скрыть пароль',
          onPressed: () => setState(() => _hidden = !_hidden),
          icon: Icon(_hidden ? Icons.visibility : Icons.visibility_off),
        ) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
