import 'package:flutter/material.dart';

import 'screens/dashboard.dart';
import 'screens/profile.dart';
import 'screens/transaction.dart';
import 'screens/login.dart';

void main() {
  runApp(const SmartExpenseApp());
}

class SmartExpenseApp extends StatelessWidget {
  const SmartExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Smart Expense',

      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),

      // ================= START PAGE =================
      home: const LoginPage(),
    );
  }
}

// ================= HOME PAGE =================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),

    TransactionPage(),

    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        selectedItemColor: Colors.indigo,

        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: "Transactions",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
