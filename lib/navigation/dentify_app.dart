import 'package:dentify_flutter/appointments_screen.dart';
import 'package:dentify_flutter/iam/presentation/di/presentation_module.dart';
import 'package:dentify_flutter/iam/presentation/view/login.dart';
import 'package:dentify_flutter/iam/presentation/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'drawer_wrapper.dart'; // Importa DrawerWrapper
import '../home_screen.dart';
import '../profile_screen.dart';

class DentifyApp extends ConsumerWidget {
  const DentifyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.read(loginViewModelProvider);
    final registerViewModel = ref.read(registerViewModelProvider);

    return MaterialApp(
      title: 'Dentify App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(
              viewModel: loginViewModel,
              onLogin: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              toRegister: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
        '/register': (context) => RegisterPage(
              viewModel: registerViewModel,
              onRegister: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              toLogin: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
        '/home': (context) => DrawerWrapper(content: HomeScreen()),
        '/appointments': (context) => DrawerWrapper(content: AppointmentsScreen()),
        '/profile': (context) => DrawerWrapper(content: ProfileScreen()),
      },
      
    );
  }
}
