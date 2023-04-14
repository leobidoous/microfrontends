class BillingAddressEntity {
  String city;
  String postalCode;
  String countryCode;
  String neighborhood;
  String line1;
  String line2;
  String line3;
  String state;

  BillingAddressEntity({
    required this.city,
    required this.line2,
    required this.postalCode,
    this.countryCode = 'BR',
    required this.neighborhood,
    required this.line1,
    required this.line3,
    required this.state,
  });
}
