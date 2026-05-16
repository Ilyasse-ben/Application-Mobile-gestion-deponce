import 'package:flutter/material.dart';
import 'package:smart_app_flutter_gestion_depandence/main.dart';

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String errorMessage = "";

  void login() {
    String email = emailController.text.trim();

    String password = passwordController.text.trim();

    // ================= STATIC LOGIN =================
    if (email == "user@gmail.com" && password == "1234") {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      setState(() {
        errorMessage = "Invalid email or password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Container(
            width: 400,

            padding: const EdgeInsets.all(30),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                // ================= ICON =================
                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.indigo,
                  ),
                ),

                const SizedBox(height: 20),

                // ================= TITLE =================
                const Text(
                  "Welcome Back",

                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Login to Smart Expense",

                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),

                const SizedBox(height: 30),

                // ================= EMAIL =================
                TextField(
                  controller: emailController,

                  decoration: InputDecoration(
                    labelText: "Email",

                    prefixIcon: const Icon(Icons.email),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= PASSWORD =================
                TextField(
                  controller: passwordController,

                  obscureText: true,

                  decoration: InputDecoration(
                    labelText: "Password",

                    prefixIcon: const Icon(Icons.lock),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ================= ERROR =================
                if (errorMessage.isNotEmpty)
                  Text(errorMessage, style: const TextStyle(color: Colors.red)),

                const SizedBox(height: 20),

                // ================= LOGIN BUTTON =================
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: login,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    child: const Text(
                      "Login",

                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
