import 'analysis_entity.dart';
import '../ticket/discount_entity.dart';
import 'history_ticket_entity.dart';
import 'status_class_entity.dart';

class TicketEntity {
  const TicketEntity({
    this.plate,
    this.ticket,
    required this.tempoLimitePermanencia,
    required this.status,
    required this.entradaDatahora,
    required this.validadeDatahora,
    required this.valorTotal,
    required this.valorPago,
    required this.valorDevido,
    required this.valorAdquirente,
    required this.transacao,
    required this.isAean13,
    required this.transacaoValidadeDatahora,
    required this.analysis,
    required this.discount,
    required this.historys,
    required this.isPaid,
  });

  final DateTime entradaDatahora;
  final DateTime validadeDatahora;
  final DateTime transacaoValidadeDatahora;
  final DateTime tempoLimitePermanencia;
  final String? plate;
  final String? ticket;
  final StatusClassEntity status;
  final String valorTotal;
  final String valorPago;
  final String valorDevido;
  final String valorAdquirente;
  final String transacao;
  final bool isAean13;
  final AnalysisEntity analysis;
  final DiscountEntity discount;
  final List<HistoryEntity>? historys;
  final bool isPaid;
}
