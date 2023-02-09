class TransactionEntity {
  final String transactionUuid;
  final String description;
  final String type;
  final double amount;
  final bool refund;
  final DateTime date;

  TransactionEntity({
    required this.transactionUuid,
    required this.description,
    required this.type,
    required this.amount,
    required this.refund,
    required this.date,
  });
}
