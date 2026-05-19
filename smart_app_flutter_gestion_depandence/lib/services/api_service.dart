import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/transaction_model.dart';
import '../models/budget_model.dart';

class ApiService {
  // ANDROID EMULATOR
  static const String baseUrl = "http://localhost:8080/api";


  /*
   * GET ALL TRANSACTIONS
   */
  static Future<List<TransactionModel>> getTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/transactions'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => TransactionModel.fromJson(e)).toList();
    }

    throw Exception("Failed to load transactions");
  }
  static Future<void> addTransaction(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/transactions"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add transaction");
    }
  }
  static Future<void> deleteTransaction(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/transactions/$id"));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete transaction");
    }
  }
  static Future<BudgetModel> getBudget(String month) async {
    final response = await http.get(Uri.parse("$baseUrl/budgets/$month"));

    return BudgetModel.fromJson(jsonDecode(response.body));
  }

  static Future<void> saveBudget(BudgetModel budget) async {
    await http.post(
      Uri.parse("$baseUrl/budgets"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode(budget.toJson()),
    );
  }
}
