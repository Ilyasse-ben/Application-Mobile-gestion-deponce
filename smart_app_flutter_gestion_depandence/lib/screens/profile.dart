import 'package:flutter/material.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // ================= PROFILE CARD =================
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),

                gradient: const LinearGradient(
                  colors: [Color(0xFF5B5FEF), Color(0xFF7B61FF)],
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // AVATAR
                  Container(
                    padding: const EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),

                    child: const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,

                      child: Icon(Icons.person, size: 55, color: Colors.indigo),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // NAME
                  const Text(
                    "USER",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // EMAIL
                  const Text(
                    "user@gmail.com",

                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= SETTINGS =================
            buildCard(
              icon: Icons.account_balance_wallet,
              title: "Monthly Budget",
              subtitle: "\$5000",
              color: Colors.green,
            ),

            const SizedBox(height: 15),

            buildCard(
              icon: Icons.bar_chart,
              title: "Statistics",
              subtitle: "View your expense analytics",
              color: Colors.orange,
            ),

            const SizedBox(height: 15),

            buildCard(
              icon: Icons.notifications,
              title: "Notifications",
              subtitle: "Enabled",
              color: Colors.blue,
              trailing: Switch(value: true, onChanged: (value) {}),
            ),

            const SizedBox(height: 15),

            buildCard(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              subtitle: "Coming soon",
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 15),

            buildCard(
              icon: Icons.info_outline,
              title: "About App",
              subtitle: "Smart Expense v1.0",
              color: Colors.teal,
            ),

            const SizedBox(height: 30),

            // ================= LOGOUT BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },

                icon: const Icon(Icons.logout),

                label: const Text("Logout", style: TextStyle(fontSize: 18)),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,

                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CUSTOM CARD =================
  Widget buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ICON
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 16),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          trailing ??
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
