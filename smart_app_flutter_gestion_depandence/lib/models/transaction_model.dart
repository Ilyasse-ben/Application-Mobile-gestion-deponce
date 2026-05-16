class TransactionModel {
  final int id;
  final String note;
  final double amount;
  final String type;
  final String date;
  final String category;
  TransactionModel({
    required this.id,
    required this.note,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      note: json['note'],
      amount: json['amount'].toDouble(),
      type: json['type'],
      date: json['date'],
      category: json['category'] ?? "OTHER",    );
  }
}
