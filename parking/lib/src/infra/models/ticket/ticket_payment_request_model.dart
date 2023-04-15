import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../../domain/entities/ticket/ticket_payment_request_entity.dart';

class TicketPaymentRequestModel extends TicketPaymentRequestEntity
    with EquatableMixin {
  TicketPaymentRequestModel({
    required super.customer,
    required super.idMall,
    required super.last4,
    required super.sessionId,
    required super.transaction,
  });

  factory TicketPaymentRequestModel.fromMap(Map<String, dynamic> map) {
    return TicketPaymentRequestModel(
      customer: map['customer'] ?? '',
      idMall: map['id_mall'] ?? '',
      last4: map['last4'] ?? '',
      sessionId: map['session_id'] ?? '',
      transaction: map['transaction'] ?? '',
    );
  }

  factory TicketPaymentRequestModel.fromEntity(
    TicketPaymentRequestEntity entity,
  ) {
    return TicketPaymentRequestModel(
      customer: entity.customer,
      idMall: entity.idMall,
      last4: entity.last4,
      sessionId: entity.sessionId,
      transaction: entity.transaction,
    );
  }

  factory TicketPaymentRequestModel.fromJson(String source) =>
      TicketPaymentRequestModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TicketPaymentRequestEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'customer': customer,
      'id_mall': idMall,
      'session_id': sessionId,
      'transaction': transaction,
      if (last4 != null) 'last4': last4,
    };
  }

  @override
  List<Object?> get props => [
        customer,
        idMall,
        last4,
        sessionId,
        transaction,
      ];

  @override
  bool? get stringify => true;
}
