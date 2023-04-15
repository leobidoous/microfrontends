import 'dart:convert';

import 'package:core/core.dart';

import '../../../domain/entities/ticket/ticket_payment_entity.dart';

class TicketPaymentModel extends TicketPaymentEntity with EquatableMixin {
  TicketPaymentModel({
    required super.ticket,
    required super.entradaDatahora,
    required super.validadeDatahora,
    required super.valorTotal,
    required super.valorPago,
    required super.transacao,
    required super.registroDatahora,
  });

  factory TicketPaymentModel.fromMap(Map<String, dynamic> map) {
    return TicketPaymentModel(
      ticket: map['ticket'] ?? '',
      entradaDatahora: DateFormat.tryParseOrDateNow(map['entrada_datahora']),
      validadeDatahora: DateFormat.tryParseOrDateNow(map['validade_datahora']),
      valorTotal: map['valor_total'] ?? '',
      valorPago: map['valor_pago'] ?? '',
      transacao: map['transacao'] ?? '',
      registroDatahora: DateFormat.tryParseOrDateNow(map['registro_datahora']),
    );
  }

  factory TicketPaymentModel.fromEntity(TicketPaymentEntity entity) {
    return TicketPaymentModel(
      ticket: entity.ticket,
      entradaDatahora: entity.entradaDatahora,
      validadeDatahora: entity.validadeDatahora,
      valorTotal: entity.valorTotal,
      valorPago: entity.valorPago,
      transacao: entity.transacao,
      registroDatahora: entity.registroDatahora,
    );
  }

  factory TicketPaymentModel.fromJson(String source) =>
      TicketPaymentModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TicketPaymentEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'ticket': ticket,
      'entrada_datahora': entradaDatahora,
      'validade_datahora': validadeDatahora,
      'valor_total': valorTotal,
      'valor_pago': valorPago,
      'transacao': transacao,
      'registro_datahora': registroDatahora,
    };
  }

  @override
  List<Object?> get props => [
        ticket,
        entradaDatahora,
        validadeDatahora,
        valorTotal,
        valorPago,
        transacao,
        registroDatahora,
      ];

  @override
  bool? get stringify => true;
}
