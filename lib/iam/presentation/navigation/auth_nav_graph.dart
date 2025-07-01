import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/presentation_module.dart';
import '../view/login.dart';
import '../view/register.dart';

// auth_routes.dart
Map<String, WidgetBuilder> authRoutes(WidgetRef ref) {
  final loginVM = ref.read(loginViewModelProvider);
  final registerVM = ref.read(registerViewModelProvider);
  return {
    '/login': (context) => LoginPage(
          viewModel: loginVM,
          onLogin: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          toRegister: () {
            Navigator.pushNamed(context, '/register');
          },
        ),
    '/register': (context) => RegisterPage(
          viewModel: registerVM,
          onRegister: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          toLogin: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
  };
}

