class ShoppingEntity {
  final int id;
  final String name;
  final String type;
  final String latitude, longitude;
  final String qrcode;
  final int idAdministrator;
  final String updatedAt, createdAt;
  final String address;
  final String logoImage;
  final String cnpj;

  ShoppingEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.qrcode,
    required this.idAdministrator,
    required this.updatedAt,
    required this.createdAt,
    required this.address,
    required this.logoImage,
    required this.cnpj,
  });
}
