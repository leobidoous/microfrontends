import 'package:auth/auth.dart';
import 'package:core/core.dart';

class SessionController extends GenController<Exception, SessionEntity> {
  SessionController(
    super.value, {
    required this.authUsecase,
    required this.localUserUsecase,
  });

  final IAuthUsecase authUsecase;
  final ILocalUserUsecase localUserUsecase;

  ExternalUserEntity get externalUser => state.externalUser;
  CustomerEntity get customer => state.customer;
  ClaimsEntity get claims => state.claims;
  TokenEntity get token => state.token;
  UserEntity get user => state.user;

  bool get hasEmailVerified => customer.emailVerifiedAt.isNotEmpty;

  Future<void> updateSession({
    ExternalUserEntity? externalUser,
    CustomerEntity? customer,
    ClaimsEntity? claims,
    TokenEntity? token,
    UserEntity? user,
  }) async {
    final sessionUpdated = SessionModel.fromEntity(state).copyWith(
      externalUser: externalUser,
      customer: customer,
      claims: claims,
      token: token,
      user: user,
    );
    if (authUsecase.sessionIsValid(sessionUpdated)) {
      final response =
          await localUserUsecase.setSession(session: sessionUpdated);
      return response.fold(
        (l) async {
          await logout();
          return setError(l);
        },
        (r) => update(sessionUpdated),
      );
    }
  }

  Future<void> logout() async {
    await authUsecase.logout();
  }
}
