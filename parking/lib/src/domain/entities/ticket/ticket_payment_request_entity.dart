class TicketPaymentRequestEntity {
  final String idMall;
  final String transaction;
  final String sessionId;
  final String? last4;
  final String customer;

  const TicketPaymentRequestEntity({
    required this.idMall,
    required this.transaction,
    required this.sessionId,
    this.last4,
    required this.customer,
  });
}
