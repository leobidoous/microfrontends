class CreditDataEntity {

  CreditDataEntity({
    required this.collectedAt,
    required this.creditLimit,
    required this.cuttingDate,
    required this.endDate,
    required this.interestRate,
    required this.lastPaymentDate,
    required this.lastPeriodBalance,
    required this.minimumPayment,
    required this.monthlyPayment,
    required this.nextPaymentDate,
    required this.noInterestPayment,
  });

  final DateTime collectedAt;
  final double creditLimit;
  final String cuttingDate;
  final String? endDate;
  final double interestRate;
  final String lastPaymentDate;
  final String lastPeriodBalance;
  final double minimumPayment;
  final double? monthlyPayment;
  final String nextPaymentDate;
  final String? noInterestPayment;

}
