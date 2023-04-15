class AddVehicleEntity {
  const AddVehicleEntity({
    this.brandId,
    this.modelId,
    this.plate,
    this.main,
  });

  final int? brandId;
  final int? modelId;
  final String? plate;
  final bool? main;
}
