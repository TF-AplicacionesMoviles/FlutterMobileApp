import 'package:flutter/material.dart';
import 'drawer_wrapper.dart';  // Importa DrawerWrapper
import '../home_screen.dart';
import '../profile_screen.dart';
import '../appointments_screen.dart' ;

void main() {
  runApp(DentifyApp());
}

class DentifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dentify App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DrawerWrapper(content: HomeScreen()),
        '/home': (context) => DrawerWrapper(content: HomeScreen()),
        '/appointments': (context) => DrawerWrapper(content: AppointmentsScreen()),
        '/profile': (context) => DrawerWrapper(content: ProfileScreen()),
        // Agrega las demás rutas
      },
    );
  }
}
