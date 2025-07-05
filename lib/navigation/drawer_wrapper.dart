import 'package:flutter/material.dart';

class DrawerWrapper extends StatelessWidget {
  final Widget content;

  const DrawerWrapper({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Dentify App"),
      
      ),
      drawer: Drawer(
        child: DrawerContent(
          onItemSelected: (route) {
            Navigator.of(context).pushNamed(route); // Navega a la ruta seleccionada
          },
        ),
      ),
      body: Padding(padding: const EdgeInsets.all(8.0), child: content),
    );
  }
}

class DrawerContent extends StatelessWidget {
  final Function(String) onItemSelected;

  const DrawerContent({required this.onItemSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.account_circle, size: 40),
              SizedBox(width: 16),
              Text('Dentify App', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
        ListTile(
          title: const Text("Home"),
          onTap: () => onItemSelected("/home"), // Ruta a Home
        ),
        ListTile(
          title: const Text("Appointments"),
          onTap: () => onItemSelected("/appointments"), // Ruta a Appointments
        ),
        ListTile(
          title: const Text("Patients"),
          onTap: () => onItemSelected("/patients"), // Ruta a Patients
        ),
        ListTile(
          title: const Text("Inventory"),
          onTap: () => onItemSelected("/inventory"), // Ruta a Inventory
        ),
        ListTile(
          title: const Text("Payments"),
          onTap: () => onItemSelected("/payments"), // Ruta a Payments
        ),
        ListTile(
          title: const Text("Profile"),
          onTap: () => onItemSelected("/profile"), // Ruta a Profile
        ),
        ListTile(
          title: const Text("Settings"),
          onTap: () => onItemSelected("/settings"), // Ruta a Settings
        ),
      ],
    );
  }
}
