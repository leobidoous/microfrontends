class TicketPaymentEntity {
  final DateTime entradaDatahora;
  final DateTime validadeDatahora;
  final String ticket;
  final String valorTotal;
  final String valorPago;
  final String transacao;
  final DateTime registroDatahora;

  const TicketPaymentEntity({
    required this.ticket,
    required this.entradaDatahora,
    required this.validadeDatahora,
    required this.valorTotal,
    required this.valorPago,
    required this.transacao,
    required this.registroDatahora,
  });
}
