import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/enums/transaction_method.dart';
import '../../domain/enums/transaction_type.dart';
import 'acquirer_payment_model.dart';
import 'order_model.dart';
import 'seller_model.dart';

class TransactionModel extends TransactionEntity with EquatableMixin {
  TransactionModel({
    required super.id,
    required super.updatedAt,
    required super.paymentProcessor,
    required super.insertedAt,
    required super.method,
    required super.additionCents,
    required super.status,
    required super.discountCents,
    required super.refundReason,
    required super.confirmedAt,
    required super.subtotalCents,
    required super.totalCents,
    required super.type,
    required super.seller,
    required super.order,
    required super.acquirerPayment,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '',
      updatedAt: DateFormat.tryParseOrDateNow(map['updatedAt']),
      paymentProcessor: map['paymentProcessor'] ?? '',
      insertedAt: DateFormat.tryParseOrDateNow(map['insertedAt']),
      method: transactionMethodFromJson(map['method']),
      additionCents: double.tryParse(map['additionCents'].toString()) ?? 0.0,
      status: map['status'] ?? '',
      discountCents: double.tryParse(map['discountCents'].toString()) ?? 0.0,
      refundReason: map['refundReason'] ?? '',
      confirmedAt: DateFormat.tryParseOrDateNow(map['co.toString()nfirmedAt']),
      subtotalCents: double.tryParse(map['subtotalCents'].toString()) ?? 0.0,
      totalCents: double.tryParse(map['totalCents'].toString()) ?? 0.0,
      type: transactionTypeFromJson(map['type']),
      seller: SellerModel.fromMap(map['publicSeller'] ?? {}),
      acquirerPayment: AcquirerPaymentModel.fromMap(
        map['acquirerPayment'] ?? {},
      ),
      order: OrderModel.fromMap(map['order'] ?? {}),
    );
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      updatedAt: entity.updatedAt,
      paymentProcessor: entity.paymentProcessor,
      insertedAt: entity.insertedAt,
      method: entity.method,
      additionCents: entity.additionCents,
      status: entity.status,
      discountCents: entity.discountCents,
      refundReason: entity.refundReason,
      confirmedAt: entity.confirmedAt,
      subtotalCents: entity.subtotalCents,
      totalCents: entity.totalCents,
      type: entity.type,
      seller: entity.seller,
      acquirerPayment: entity.acquirerPayment,
      order: entity.order,
    );
  }

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TransactionEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'updatedAt': updatedAt,
      'paymentProcessor': paymentProcessor,
      'insertedAt': insertedAt,
      'method': method.toJson,
      'additionCents': additionCents,
      'status': status,
      'discountCents': discountCents,
      'refundReason': refundReason,
      'confirmedAt': confirmedAt,
      'subtotalCents': subtotalCents,
      'totalCents': totalCents,
      'type': type.toJson,
      'publicSeller': SellerModel.fromEntity(seller).toJson,
      'order': OrderModel.fromEntity(order).toJson,
      'acquirerPayment':
          AcquirerPaymentModel.fromEntity(acquirerPayment).toJson,
    };
  }

  @override
  List<Object?> get props => [
        id,
        updatedAt,
        paymentProcessor,
        insertedAt,
        method,
        additionCents,
        status,
        discountCents,
        refundReason,
        confirmedAt,
        subtotalCents,
        seller,
        totalCents,
        type,
        acquirerPayment,
        order,
      ];

  @override
  bool? get stringify => true;
}
