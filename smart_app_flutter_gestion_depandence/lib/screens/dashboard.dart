import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/transaction_model.dart';
import '../services/api_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<TransactionModel>> transactions;

  double monthlyBudget = 3000;

  // ================= ALERT =================
  bool alertShown = false;

  @override
  void initState() {
    super.initState();

    transactions = ApiService.getTransactions();
  }

  // ================= ALERT POPUP =================
  void showBudgetAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Budget Alert"),

          content: const Text(
            "⚠ You exceeded your monthly budget!",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // ================= INCOME =================
  double getIncome(List<TransactionModel> data) {
    return data
        .where((t) => t.type == "INCOME")
        .fold(0, (sum, item) => sum + item.amount);
  }

  // ================= EXPENSE =================
  double getExpense(List<TransactionModel> data) {
    return data
        .where((t) => t.type == "EXPENSE")
        .fold(0, (sum, item) => sum + item.amount);
  }

  // ================= BUDGET =================
  double getBudgetProgress(double expense) {
    if (monthlyBudget == 0) return 0;

    return expense / monthlyBudget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Smart Expense"),
        centerTitle: true,
        elevation: 0,
      ),

      body: FutureBuilder<List<TransactionModel>>(
        future: transactions,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.data!;

          final income = getIncome(data);

          final expense = getExpense(data);

          final budgetProgress =
              getBudgetProgress(expense);

          // ================= ALERT CHECK =================
          if (expense > monthlyBudget &&
              !alertShown &&
              monthlyBudget > 0) {

            WidgetsBinding.instance
                .addPostFrameCallback((_) {
              showBudgetAlert();
            });

            alertShown = true;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // ================= BALANCE CARD =================
                Container(
                  height: 180,
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(24),

                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5B5FEF),
                        Color(0xFF7B61FF),
                      ],
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Total Balance",

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${(income - expense).toStringAsFixed(2)} MAD",

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          Text(
                            "Income\n${income.toStringAsFixed(2)} MAD",

                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),

                          Text(
                            "Expense\n${expense.toStringAsFixed(2)} MAD",

                            textAlign: TextAlign.right,

                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ================= STATS =================
                Row(
                  children: [

                    Expanded(
                      child: _statCard(
                        "Income",
                        income,
                        Colors.green,
                        Icons.arrow_downward,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _statCard(
                        "Expense",
                        expense,
                        Colors.red,
                        Icons.arrow_upward,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= BUDGET =================
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Monthly Budget",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${expense.toStringAsFixed(2)} MAD / ${monthlyBudget.toStringAsFixed(2)} MAD",

                        style: TextStyle(
                          color:
                              expense > monthlyBudget
                                  ? Colors.red
                                  : Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 10),

                      LinearProgressIndicator(
                        value: budgetProgress > 1
                            ? 1
                            : budgetProgress,

                        backgroundColor:
                            Colors.grey[200],

                        color:
                            expense > monthlyBudget
                                ? Colors.red
                                : Colors.green,

                        minHeight: 10,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        expense > monthlyBudget
                            ? "⚠ Budget exceeded!"
                            : "${(budgetProgress * 100).toStringAsFixed(1)}% used",

                        style: TextStyle(
                          color:
                              expense > monthlyBudget
                                  ? Colors.red
                                  : Colors.green,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ================= PIE CHART =================
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(24),
                  ),

                  child: PieChart(
                    PieChartData(
                      sections: [

                        PieChartSectionData(
                          value: income,
                          color: Colors.green,
                          title: "Income",
                          radius: 60,
                        ),

                        PieChartSectionData(
                          value: expense,
                          color: Colors.red,
                          title: "Expense",
                          radius: 60,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= LINE CHART =================
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(24),
                  ),

                  child: LineChart(
                    LineChartData(
                      lineBarsData: [

                        LineChartBarData(
                          spots: List.generate(
                            data.length,

                            (i) => FlSpot(
                              i.toDouble(),
                              data[i].amount,
                            ),
                          ),

                          isCurved: true,
                          color: Colors.indigo,
                          barWidth: 3,

                          dotData:
                              const FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ================= RECENT TRANSACTIONS =================
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "Recent Transactions",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ...data.take(5).map(
                        (t) => ListTile(
                          contentPadding:
                              EdgeInsets.zero,

                          leading: CircleAvatar(
                            backgroundColor:
                                t.type == "INCOME"
                                    ? Colors.green
                                        .withOpacity(0.2)
                                    : Colors.red
                                        .withOpacity(0.2),

                            child: Icon(
                              t.type == "INCOME"
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,

                              color:
                                  t.type == "INCOME"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),

                          title: Text(t.note),

                          subtitle: Text(t.date),

                          trailing: Text(
                            "${t.type == "INCOME" ? "+" : "-"} ${t.amount} MAD",

                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,

                              color:
                                  t.type == "INCOME"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(
    String title,
    double value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(icon, color: color),

          const SizedBox(height: 12),

          Text(
            title,

            style: const TextStyle(
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "${value.toStringAsFixed(2)} MAD",

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}