import 'package:core/core.dart';


class SessionController extends GenController<Exception, SessionEntity> {
  SessionController(super.value, {required this.authUsecase});

  final IAuthUsecase authUsecase;

  ExternalUserEntity get externalUser => state.externalUser;
  CustomerEntity get customer => state.customer;
  ClaimsEntity get claims => state.claims;
  TokenEntity get token => state.token;
  UserEntity get user => state.user;

  bool get hasEmailVerified => customer.emailVerifiedAt.isNotEmpty;

  Future<void> logout() async {
    await authUsecase.logout();
  }
}
