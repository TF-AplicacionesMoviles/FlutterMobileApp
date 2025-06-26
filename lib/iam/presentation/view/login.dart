import 'package:flutter/material.dart';
import '../viewmodel/login_view_model.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel viewModel;
  final VoidCallback onLogin;
  final VoidCallback toRegister;

  const LoginPage({required this.viewModel, required this.onLogin, required this.toRegister});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => viewModel.username = value,  // Acceder correctamente a la propiedad
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              obscureText: true,
              onChanged: (value) => viewModel.password = value,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            if (viewModel.errorMessage != null)
              Text(viewModel.errorMessage!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () {
                viewModel.login();
                if (viewModel.isAuthenticated) {
                  onLogin();
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: toRegister,
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
