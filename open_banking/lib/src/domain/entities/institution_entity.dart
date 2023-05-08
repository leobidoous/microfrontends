class InstitutionEntity {

  InstitutionEntity({
    required this.code,
    required this.countryCode,
    required this.countryCodes,
    required this.displayName,
    required this.iconLogo,
    required this.id,
    required this.logo,
    required this.name,
    required this.primaryColor,
    required this.resources,
    required this.status,
    required this.textLogo,
    required this.type,
    required this.website,
  });

  final String code;
  final String countryCode;
  final List<dynamic> countryCodes;
  final String displayName;
  final String iconLogo;
  final int id;
  final String logo;
  final String name;
  final String primaryColor;
  final List<dynamic> resources;
  final String status;
  final String textLogo;
  final String type;
  final String website;

}
