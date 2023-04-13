import '../../../../shared/domain/interfaces/gen_controller.dart';
import '../../../auth/domain/usecases/i_auth_usecase.dart';
import '../../domain/entities/claims_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/external_user_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';

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
