class LoanDataEntity {
  
  LoanDataEntity({
    required this.balanceType,
    required this.bankProductId,
    required this.category,
    required this.collectedAt,
    required this.createdAt,
    required this.currency,
    required this.externalId,
    required this.internalIdentification,
    required this.lastAccessedAt,
    required this.name,
    required this.number,
    required this.publicIdentificationName,
    required this.publicIdentificationValue,
    required this.type,
  });

  final String balanceType;
  final String bankProductId;
  final String category;
  final String collectedAt;
  final String createdAt;
  final String currency;
  final String externalId;
  final String internalIdentification;
  final String lastAccessedAt;
  final String name;
  final String number;
  final String publicIdentificationName;
  final String publicIdentificationValue;
  final String type;

}
