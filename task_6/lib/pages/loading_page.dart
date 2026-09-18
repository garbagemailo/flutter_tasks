import 'dart:async';
import 'package:flutter/material.dart';
import '../routes.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late final Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted) Navigator.pushReplacementNamed(context, Routes.login);
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: SafeArea(child: Center(child: SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CircleAvatar(radius: 48, child: Icon(Icons.data_object, size: 52)),
        SizedBox(height: 40),
        Text('Форматы данных', textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'FormatTitle', fontSize: 26,
            fontWeight: FontWeight.w700)),
      ]),
    ))),
  );
}
