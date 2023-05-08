class FundDataEntity {
  
  FundDataEntity({
    required this.collectedAt,
    required this.holderName,
    required this.issuer,
    required this.method,
    required this.number,
  });

  final String collectedAt;
  final String holderName;
  final String issuer;
  final String method;
  final String number;

}
