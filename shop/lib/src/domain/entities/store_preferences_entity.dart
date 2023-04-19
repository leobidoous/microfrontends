class StorePreferencesEntity {
  final bool allowInstallment;
  final bool allowMethods;
  final int defaultMaxInstallments;
  final Map<String, dynamic> defaultPaymentMethods;
  final bool eatIn;
  final bool serviceCharge;
  final bool takeOut;
  final bool usingDelivery;

  StorePreferencesEntity({
    required this.allowInstallment,
    required this.allowMethods,
    required this.defaultMaxInstallments,
    required this.defaultPaymentMethods,
    required this.eatIn,
    required this.serviceCharge,
    required this.takeOut,
    required this.usingDelivery,
  });
}
