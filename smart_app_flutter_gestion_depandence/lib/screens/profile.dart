import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 20),

            const Text(
              "Ilyasse",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text("Monthly Budget"),
              trailing: const Text("\$5000"),
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notifications"),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}
