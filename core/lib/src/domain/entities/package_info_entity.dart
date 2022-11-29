class PackageInfoEntity {
  final String appName;
  final String name;
  final String version;
  final String buildNumber;
  final String buildSignature;

  PackageInfoEntity({
    required this.appName,
    required this.name,
    required this.version,
    required this.buildNumber,
    required this.buildSignature,
  });
}
