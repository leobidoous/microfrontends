class HistoryEntity {
  HistoryEntity({
    this.id,
    required this.pagoEm,
    required this.saidaAte,
    this.valorPago,
  });

  String? id;
  DateTime pagoEm;
  DateTime saidaAte;
  String? valorPago;

}