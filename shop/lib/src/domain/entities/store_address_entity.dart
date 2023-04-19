class StoreAddressEntity {
  final String city;
  final String countryCode;
  final String id;
  final String line1;
  final String line2;
  final String line3;
  final String neighborhood;
  final String postalCode;
  final String state;

  StoreAddressEntity({
    required this.city,
    this.countryCode = 'BR',
    required this.id,
    required this.line1,
    required this.line2,
    required this.line3,
    required this.neighborhood,
    required this.postalCode,
    required this.state,
  });
}
