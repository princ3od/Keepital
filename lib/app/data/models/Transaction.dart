class Transaction {
  Transaction(
      {required TransactionType type,
      required String category,
      required double amount,
      String? note})
      : Category = category,
        Type = type,
        Amount = amount,
        Note = note;

  String Category;
  TransactionType Type;
  double Amount;
  String? Note;
}

enum TransactionType { Inflow, Outflow }
