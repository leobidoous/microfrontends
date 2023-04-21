import 'dart:convert';

import 'package:core/core.dart';

import '../../../domain/entities/dashboard/history_entity.dart';
import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../ticket/discount_model.dart';
import 'analysis_model.dart';
import 'history_ticket_model.dart';
import 'status_class_model.dart';

class TicketModel extends TicketEntity with EquatableMixin {
  TicketModel({
    super.plate,
    super.ticket,
    required super.tempoLimitePermanencia,
    required super.status,
    required super.entradaDatahora,
    required super.validadeDatahora,
    required super.valorTotal,
    required super.valorPago,
    required super.valorDevido,
    required super.valorAdquirente,
    required super.transacao,
    required super.isAean13,
    required super.transacaoValidadeDatahora,
    required super.analysis,
    required super.discount,
    required super.historys,
    required super.isPaid,
  });

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      plate: map['placa'],
      ticket: map['ticket'],
      tempoLimitePermanencia:
          DateFormat.tryParseOrDateNow(map['tempo_limite_permanencia']),
      status: StatusClassModel.fromMap(map['status'] ?? {}),
      entradaDatahora: DateFormat.tryParseOrDateNow(map['entrada_datahora']),
      validadeDatahora: DateFormat.tryParseOrDateNow(map['validade_datahora']),
      valorTotal: map['valor_total'] ?? '',
      valorPago: map['valor_pago'] ?? '',
      valorDevido: map['valor_devido'] ?? '',
      valorAdquirente: map['valor_adquirente'] ?? '',
      transacao: map['transacao'] ?? '',
      isAean13: map['is_aean13'] ?? false,
      transacaoValidadeDatahora: DateFormat.tryParseOrDateNow(
        map['transacao_validade_datahora'],
      ),
      analysis: AnalysisModel.fromMap(map['analise'] ?? {}),
      discount: DiscountModel.fromMap(map['discount'] ?? {}),
      historys: (map['history'] is List<HistoryEntity>)
          ? map['history']
              .map((element) => HistoryModel.fromMap(element))
              .toList()
          : [],
      isPaid: map['is_paid'] ?? false,
    );
  }

  factory TicketModel.fromEntity(TicketEntity entity) {
    return TicketModel(
      plate: entity.plate,
      ticket: entity.ticket,
      tempoLimitePermanencia: entity.tempoLimitePermanencia,
      status: entity.status,
      entradaDatahora: entity.entradaDatahora,
      validadeDatahora: entity.validadeDatahora,
      valorTotal: entity.valorTotal,
      valorPago: entity.valorPago,
      valorDevido: entity.valorDevido,
      valorAdquirente: entity.valorAdquirente,
      transacao: entity.transacao,
      isAean13: entity.isAean13,
      transacaoValidadeDatahora: entity.transacaoValidadeDatahora,
      analysis: entity.analysis,
      discount: entity.discount,
      historys: entity.historys,
      isPaid: entity.isPaid,
    );
  }

  factory TicketModel.fromJson(String source) =>
      TicketModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TicketEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'placa': plate,
      'ticket': ticket,
      'tempo_limite_permanencia': tempoLimitePermanencia,
      'status': StatusClassModel.fromEntity(status).toMap,
      'entrada_datahora': entradaDatahora,
      'validade_datahora': validadeDatahora,
      'valor_total': valorTotal,
      'valor_pago': valorPago,
      'valor_devido': valorDevido,
      'valor_adquirente': valorAdquirente,
      'transacao': transacao,
      'is_aean13': isAean13,
      'transacao_validade_datahora': transacaoValidadeDatahora,
      'analise': analysis,
      'discount': discount,
      'is_paid': isPaid,
    };
  }

  @override
  List<Object?> get props => [
        plate,
        ticket,
        tempoLimitePermanencia,
        status,
        entradaDatahora,
        validadeDatahora,
        valorTotal,
        valorPago,
        valorDevido,
        valorAdquirente,
        transacao,
        isAean13,
        transacaoValidadeDatahora,
        analysis,
        discount,
        historys,
        isPaid,
      ];

  @override
  bool? get stringify => true;
}
