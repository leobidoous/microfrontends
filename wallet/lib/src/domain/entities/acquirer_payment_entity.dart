class AcquirerPaymentEntity {
  final String chave;
  final String cnpj;
  final String dataEmissao;
  final String model;
  final String month;
  final String qrCode;
  final String state;
  final String status;
  final String url;
  final String year;
  final String total;

  AcquirerPaymentEntity({
    required this.chave,
    required this.cnpj,
    required this.dataEmissao,
    required this.model,
    required this.month,
    required this.qrCode,
    required this.state,
    required this.status,
    required this.url,
    required this.year,
    required this.total,
  });
}
