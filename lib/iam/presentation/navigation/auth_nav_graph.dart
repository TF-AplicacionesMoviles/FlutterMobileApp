import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/presentation_module.dart';
import '../view/login.dart';
import '../view/register.dart';

void authNavGraph(BuildContext context, WidgetRef ref) {
  final loginViewModel = ref.read(loginViewModelProvider);
  final registerViewModel = ref.read(registerViewModelProvider);

  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => MaterialApp(
      routes: {
        '/login': (context) => LoginPage(
            viewModel: loginViewModel,
            onLogin: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            toRegister: () {
              Navigator.pushNamed(context, '/register');
            }),
        '/register': (context) => RegisterPage(
            viewModel: registerViewModel,
            onRegister: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            toLogin: () {
              Navigator.pushNamed(context, '/login');
            }),
      },
    ),
  ));
}
