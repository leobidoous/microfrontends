import 'claims_entity.dart';

class FirebaseTokenResultEntity {
  final ClaimsEntity claims;
  final String token;
  final String signInProvider;

  FirebaseTokenResultEntity({
    required this.claims,
    required this.token,
    required this.signInProvider,
  });
}
