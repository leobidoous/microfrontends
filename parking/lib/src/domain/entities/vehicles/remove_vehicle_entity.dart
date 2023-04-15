class RemoveVehicleEntity {
  const RemoveVehicleEntity({
    this.id,
    this.plate,
    this.main,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.idModel,
    this.idBrand,
    this.idUser,
  });

  final int? id;
  final String? plate;
  final bool? main;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? idModel;
  final int? idBrand;
  final int? idUser;
}
