import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../services/api_service.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late Future<List<TransactionModel>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = ApiService.getTransactions();
  }

  void refresh() {
    setState(() {
      transactions = ApiService.getTransactions();
    });
  }

  // ================= DELETE =================
  Future<void> _deleteTransaction(int id) async {
    await ApiService.deleteTransaction(id);

    setState(() {
      transactions = ApiService.getTransactions();
    });
  }

  // ================= ADD TRANSACTION =================
  void _showAddDialog() {
    final noteController = TextEditingController();
    final amountController = TextEditingController();

    String type = "EXPENSE";
    String category = "FOOD";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Transaction"),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // NOTE
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(labelText: "Note"),
                ),

                const SizedBox(height: 10),

                // AMOUNT
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Amount"),
                ),

                const SizedBox(height: 10),

                // TYPE
                DropdownButtonFormField<String>(
                  value: type,

                  decoration: const InputDecoration(labelText: "Type"),

                  items: const [
                    DropdownMenuItem(value: "INCOME", child: Text("Income")),

                    DropdownMenuItem(value: "EXPENSE", child: Text("Expense")),
                  ],

                  onChanged: (value) {
                    type = value!;
                  },
                ),

                const SizedBox(height: 10),

                // CATEGORY
                DropdownButtonFormField<String>(
                  value: category,

                  decoration: const InputDecoration(labelText: "Category"),

                  items: const [
                    DropdownMenuItem(value: "FOOD", child: Text("Food")),

                    DropdownMenuItem(
                      value: "TRANSPORT",
                      child: Text("Transport"),
                    ),

                    DropdownMenuItem(value: "RENT", child: Text("Rent")),

                    DropdownMenuItem(
                      value: "SHOPPING",
                      child: Text("Shopping"),
                    ),

                    DropdownMenuItem(value: "OTHER", child: Text("Other")),
                  ],

                  onChanged: (value) {
                    category = value!;
                  },
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () async {
                await ApiService.addTransaction({
                  "note": noteController.text,
                  "amount": double.parse(amountController.text),
                  "type": type,
                  "category": category,
                  "date": DateTime.now().toIso8601String().split("T")[0],
                });

                Navigator.pop(context);

                refresh();
              },

              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transactions"), centerTitle: true),

      body: FutureBuilder<List<TransactionModel>>(
        future: transactions,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data ?? [];

          return ListView.builder(
            itemCount: data.length,

            itemBuilder: (context, index) {
              final t = data[index];

              final isIncome = t.type == "INCOME";

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    // ICON
                    Container(
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: isIncome
                            ? Colors.green.withOpacity(0.15)
                            : Colors.red.withOpacity(0.15),

                        shape: BoxShape.circle,
                      ),

                      child: Icon(
                        isIncome ? Icons.arrow_downward : Icons.arrow_upward,

                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            t.note,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "${t.date} • ${t.category}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // AMOUNT + DELETE
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${isIncome ? "+" : "-"} ${t.amount} MAD",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isIncome ? Colors.green : Colors.red,
                          ),
                        ),

                        const SizedBox(width: 10),

                        // DELETE BUTTON
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),

                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Delete"),

                                  content: const Text(
                                    "Are you sure you want to delete this transaction?",
                                  ),

                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),

                                      child: const Text("Cancel"),
                                    ),

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),

                                      onPressed: () async {
                                        Navigator.pop(context);

                                        await _deleteTransaction(t.id);
                                      },

                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      // ================= ADD BUTTON =================
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,

        child: const Icon(Icons.add),
      ),
    );
  }
}
