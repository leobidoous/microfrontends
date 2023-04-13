import 'claims_entity.dart';
import 'customer_entity.dart';
import 'external_user_entity.dart';
import 'token_entity.dart';
import 'user_entity.dart';

class SessionEntity {
  final ExternalUserEntity externalUser;
  final CustomerEntity customer;
  final ClaimsEntity claims;
  final TokenEntity token;
  final UserEntity user;

  SessionEntity({
    required this.externalUser,
    required this.customer,
    required this.claims,
    required this.token,
    required this.user,
  });
}
