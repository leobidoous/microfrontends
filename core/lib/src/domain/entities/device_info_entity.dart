class DeviceInfoEntity {
  final String? id;
  final bool isPhysicalDevice;
  final String? model;
  final String? name;
  final String? systemVersion;
  final String? localizedModel;

  DeviceInfoEntity({
    this.id,
    this.isPhysicalDevice = false,
    this.model,
    this.name,
    this.systemVersion,
    this.localizedModel,
  });
}
