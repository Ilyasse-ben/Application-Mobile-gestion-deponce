class BudgetModel {
  final int? id;
  final double amount;
  final String month;

  BudgetModel({this.id, required this.amount, required this.month});

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      id: json['id'],
      amount: (json['amount'] ?? 0).toDouble(),
      month: json['month'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"amount": amount, "month": month};
  }
}
