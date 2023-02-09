import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity with EquatableMixin {
  TransactionModel({
    required super.transactionUuid,
    required super.description,
    required super.type,
    required super.amount,
    required super.refund,
    required super.date,
  });
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      transactionUuid: map['transaction_uuid'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? '',
      amount: map['amount'] ?? '',
      refund: map['refund'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    );
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      transactionUuid: entity.transactionUuid,
      description: entity.description,
      type: entity.type,
      amount: entity.amount,
      refund: entity.refund,
      date: entity.date,
    );
  }

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'transactionUuid': transactionUuid,
      'description': description,
      'type': type,
      'amount': amount,
      'refund': refund,
      'date': date,
    };
  }

  TransactionEntity get toEntity => this;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        transactionUuid,
        description,
        type,
        amount,
        refund,
        date,
      ];
}
