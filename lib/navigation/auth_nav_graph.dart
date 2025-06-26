import 'package:flutter/material.dart';

class AuthNavGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Authentication")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simula el login exitoso y navega a la pantalla principal
                Navigator.pushReplacementNamed(context, '/app');
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                // Simula el registro y navega a la pantalla principal
                Navigator.pushReplacementNamed(context, '/app');
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
