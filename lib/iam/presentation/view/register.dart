import 'package:flutter/material.dart';
import '../viewmodel/register_view_model.dart';

class RegisterPage extends StatelessWidget {
  final RegisterViewModel viewModel;
  final VoidCallback onRegister;
  final VoidCallback toLogin;

  const RegisterPage({required this.viewModel, required this.onRegister, required this.toLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => viewModel.firstName = value,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              onChanged: (value) => viewModel.lastName = value,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              onChanged: (value) => viewModel.email = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => viewModel.companyName = value,
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            TextField(
              onChanged: (value) => viewModel.username = value,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              obscureText: true,
              onChanged: (value) => viewModel.password = value,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            Row(
              children: [
                Checkbox(
                  value: viewModel.trial,
                  onChanged: (value) => viewModel.trial = value!,
                ),
                Text('Start with trial'),
              ],
            ),
            if (viewModel.errorMessage != null)
              Text(viewModel.errorMessage!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () {
                viewModel.register();
                if (viewModel.isAuthenticated) {
                  onRegister();
                }
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: toLogin,
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
