import 'package:flutter/material.dart';
import '../account.dart';
import 'text_field.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key, this.initial, this.login = false,
    required this.button, required this.onSubmit, this.extra});
  final Account? initial;
  final bool login;
  final String button;
  final String? Function(String, String, String) onSubmit;
  final Widget? extra;
  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _key = GlobalKey<FormState>();
  final _controllers = List.generate(4, (_) => TextEditingController());
  final _nodes = List.generate(4, (_) => FocusNode());
  bool _submitted = false;
  @override
  void initState() {
    super.initState();
    _controllers[0].text = widget.initial?.name ?? '';
    _controllers[1].text = widget.initial?.email ?? '';
    _controllers[2].addListener(_passwordChanged);
  }

  void _passwordChanged() {
    if (_submitted) _key.currentState?.validate();
  }

  @override
  void dispose() {
    _controllers[2].removeListener(_passwordChanged);
    for (final controller in _controllers) { controller.dispose(); }
    for (final node in _nodes) { node.dispose(); }
    super.dispose();
  }

  void _submit() {
    setState(() => _submitted = true);
    if (!(_key.currentState?.validate() ?? false)) {
      for (final i in widget.login ? [1, 2] : [0, 1, 2, 3]) {
        if (validateInput(InputFieldType.values[i], _controllers[i].text,
            password: _controllers[2].text) != null) {
          _nodes[i].requestFocus();
          break;
        }
      }
      return;
    }
    FocusScope.of(context).unfocus();
    final error = widget.onSubmit(_controllers[0].text.trim(),
        _controllers[1].text.trim().toLowerCase(), _controllers[2].text);
    if (error != null && mounted) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final indices = widget.login ? [1, 2] : [0, 1, 2, 3];
    return Form(
      key: _key,
      autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final i in indices) Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomTextFormField(
              type: InputFieldType.values[i], controller: _controllers[i],
              focusNode: _nodes[i], last: i == indices.last,
              passwordController: _controllers[2],
              onSubmitted: i == indices.last ? _submit
                  : () => _nodes[i + 1].requestFocus(),
            ),
          ),
          if (!widget.login) const Text(
            'Пароль: от 6 символов, буква, цифра и один из + _ -.'),
          if (widget.extra != null) widget.extra!,
          const SizedBox(height: 24),
          FilledButton(key: const ValueKey('submit'),
            onPressed: _submit, child: Text(widget.button)),
        ],
      ),
    );
  }
}

class FormLayout extends StatelessWidget {
  const FormLayout({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children),
      )),
    ),
  );
}
