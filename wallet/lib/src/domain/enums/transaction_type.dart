import 'package:flutter/material.dart';

enum TransactionType { other, food }

extension TransactionTypeExt on TransactionType {
  IconData get icon {
    switch (this) {
      case TransactionType.other:
        return Icons.info_outline_rounded;
      case TransactionType.food:
        return Icons.food_bank_rounded;
    }
  }
  String get toJson {
    switch (this) {
      case TransactionType.other:
        return 'other';
      case TransactionType.food:
        return 'food';
    }
  }
}

TransactionType transactionTypeFromJson(String? type) {
  switch (type) {
    case 'food':
      return TransactionType.food;
    default:
      return TransactionType.other;
  }
}
