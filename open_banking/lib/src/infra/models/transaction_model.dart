import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/transaction_entity.dart';
import '../models/transaction_merchant_model.dart';
import 'account_model.dart';
import 'credit_data_model.dart';

class TransactionModel extends TransactionEntity with EquatableMixin {

  TransactionModel({
    required super.account,
    required super.accountingDate,
    required super.amount,
    required super.balance,
    required super.category,
    required super.collectedAt,
    required super.creditData,
    required super.currency,
    required super.description,
    required super.externalId,
    required super.id,
    required super.merchant,
    required super.observations,
    required super.reference,
    required super.status,
    required super.type,
    required super.valueDate,
  });
  
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      account: AccountModel.fromMap(
        Map<String, dynamic>.from(map['account'] ?? {}),
      ),
      accountingDate: DateFormat.tryParseOrDateNow(map['accountingDate']),
      amount: map['amount'] ?? '',
      balance: map['balance'] ?? '',
      category: map['category'] ?? '',
      collectedAt: DateFormat.tryParseOrDateNow(map['collectedAt']),
      creditData: CreditDataModel.fromMap(
        Map<String, dynamic>.from(map['creditData'] ?? {}),
      ),
      currency: map['currency'] ?? '',
      description: map['description'] ?? '',
      externalId: map['externalId'] ?? '',
      id: map['id'] ?? '',
      merchant: TransactionMerchantModel.fromMap(
        Map<String, dynamic>.from(map['merchant'] ?? {}),
      ),
      observations: map['observations'] ?? '',
      reference: map['reference'] ?? '',
      status: map['status'] ?? '',
      type: map['type'] ?? '',
      valueDate: DateFormat.tryParseOrDateNow(map['valueDate']),
    );
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
       account: entity.account,
       accountingDate: entity.accountingDate,
       amount: entity.amount,
       balance: entity.balance,
       category: entity.category,
       collectedAt: entity.collectedAt,
       creditData: entity.creditData,
       currency: entity.currency,
       description: entity.description,
       externalId: entity.externalId,
       id: entity.id,
       merchant: entity.merchant,
       observations: entity.observations,
       reference: entity.reference,
       status: entity.status,
       type: entity.type,
       valueDate: entity.valueDate,
    );
  }

  factory TransactionModel.fromjson(String source) =>
  TransactionModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  TransactionModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'account': account,
      'accountingDate': accountingDate,
      'amount': amount,
      'balance': balance,
      'category': category,
      'collectedAt': collectedAt,
      'creditData': creditData,
      'currency': currency,
      'description': description,
      'externalId': externalId,
      'id': id,
      'merchant': merchant,
      'observations': observations,
      'reference': reference,
      'status': status,
      'type': type,
      'valueDate': valueDate,
    };
  }

  @override
  List<Object?> get props => [
    account,
    accountingDate,
    amount,
    balance,
    category,
    collectedAt,
    creditData,
    currency,
    description,
    externalId,
    id,
    merchant,
    observations,
    reference,
    status,
    type,
    valueDate,
  ];

  @override
  bool? get stringify => true;

}