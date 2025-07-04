import 'package:flutter/material.dart';

class AppContentNavHost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Appointments"),
              onTap: () {
                Navigator.pushNamed(context, '/appointments');
              },
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            // Agrega más elementos según lo necesites
          ],
        ),
      ),
      body: Center(
        child: Text("Main Content Area"),
      ),
    );
  }
}
