class CouponEntity {
  final double amount;
  final double amountUntilFreeParking;
  final double campaignValue;
  final int qtdCoupon;
  final bool hasUsedVoucher;
  final bool canGetFreeParking;
  final Map<String, dynamic> customerCreation;

  const CouponEntity({
    required this.amount,
    required this.canGetFreeParking,
    required this.amountUntilFreeParking,
    required this.campaignValue,
    required this.hasUsedVoucher,
    required this.qtdCoupon,
    required this.customerCreation,
  });
}
