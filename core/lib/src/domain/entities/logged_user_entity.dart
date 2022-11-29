import 'token_entity.dart';

class LoggedUserEntity {
  List<String>? businessPhones;
  String? displayName;
  String? givenName;
  String? jobTitle;
  String? mail;
  String? mobilePhone;
  String? officeLocation;
  String? preferredLanguage;
  String? surname;
  String? userPrincipalName;
  String? id;
  TokenEntity graphToken;
  TokenEntity sharepointToken;

  LoggedUserEntity({
    this.businessPhones = const [],
    required this.displayName,
    required this.givenName,
    required this.jobTitle,
    required this.mail,
    required this.mobilePhone,
    required this.officeLocation,
    required this.preferredLanguage,
    required this.surname,
    required this.userPrincipalName,
    required this.id,
    required this.graphToken,
    required this.sharepointToken,
  });
}
