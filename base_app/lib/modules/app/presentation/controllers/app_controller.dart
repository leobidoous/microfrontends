import '../../../../shared/domain/interfaces/either.dart';
import '../../../../shared/domain/interfaces/gen_controller.dart';
import '../../domain/entities/claims_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/external_user_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/i_local_user_usecase.dart';
import '../../infra/models/claims_model.dart';
import '../../infra/models/customer_model.dart';
import '../../infra/models/external_user_model.dart';
import '../../infra/models/token_model.dart';
import '../../infra/models/user_model.dart';

class AppController extends GenController<Exception, Unit> {
  AppController({required this.localUserUsecase}) : super(unit);

  final ILocalUserUsecase localUserUsecase;

  ExternalUserEntity? _externalUser;
  CustomerEntity? _customer;
  ClaimsEntity? _claims;
  TokenEntity? _token;
  UserEntity? _user;

  CustomerEntity get customer => _customer!;
  set customer(CustomerEntity customer) {
    _customer = customer;
  }

  ClaimsEntity get claims => _claims!;
  set claims(ClaimsEntity claims) {
    _claims = claims;
  }

  ExternalUserEntity get externalUser => _externalUser!;
  set externalUser(ExternalUserEntity externalUser) {
    _externalUser = externalUser;
  }

  TokenEntity get token => _token!;
  set token(TokenEntity token) {
    _token = token;
  }

  UserEntity get user => _user!;
  set user(UserEntity user) {
    _user = user;
  }

  Future<Either<Exception, Unit>> onSaveSession({
    ExternalUserEntity? externalUser,
    CustomerEntity? customer,
    ClaimsEntity? claims,
    TokenEntity? token,
    UserEntity? user,
  }) {
    final session = SessionEntity(
      externalUser: externalUser ?? ExternalUserModel.fromMap({}),
      customer: customer ?? CustomerModel.fromMap({}),
      claims: claims ?? ClaimsModel.fromMap({}),
      token: token ?? TokenModel.fromMap({}),
      user: user ?? UserModel.fromMap({}),
    );
    return localUserUsecase.setSession(session: session);
  }

  Future<Either<Exception, SessionEntity>> getSession() async {
    final sessionResponse = await localUserUsecase.getSession();
    sessionResponse.fold(
      (l) => null,
      (session) {
        externalUser = session.externalUser;
        customer = session.customer;
        claims = session.claims;
        token = session.token;
        user = session.user;
      },
    );
    return sessionResponse;
  }
}
