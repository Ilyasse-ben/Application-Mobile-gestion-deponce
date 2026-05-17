import 'package:flutter/material.dart';
import 'package:smart_app_flutter_gestion_depandence/services/api_service.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String type = "EXPENSE";
  DateTime selectedDate = DateTime.now();

  bool isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await ApiService.addTransaction({
        "amount": double.parse(amountController.text),
        "type": type,
        "note": noteController.text,
        "date": selectedDate.toIso8601String().split("T")[0],
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transaction added successfully")),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              // AMOUNT
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),

                validator: (value) => value!.isEmpty ? "Enter amount" : null,
              ),

              const SizedBox(height: 16),

              // NOTE
              TextFormField(
                controller: noteController,

                decoration: const InputDecoration(
                  labelText: "Note",
                  border: OutlineInputBorder(),
                ),

                validator: (value) => value!.isEmpty ? "Enter note" : null,
              ),

              const SizedBox(height: 16),

              // TYPE
              DropdownButtonFormField<String>(
                initialValue: type,

                items: const [
                  DropdownMenuItem(value: "INCOME", child: Text("Income")),
                  DropdownMenuItem(value: "EXPENSE", child: Text("Expense")),
                ],

                onChanged: (value) {
                  setState(() => type = value!);
                },

                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              const SizedBox(height: 16),

              // DATE
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Date: ${selectedDate.toLocal().toString().split(' ')[0]}",
                    ),
                  ),

                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );

                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    child: const Text("Pick Date"),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: isLoading ? null : _submit,

                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Save Transaction"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
