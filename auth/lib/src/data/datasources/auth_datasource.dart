import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

import '../../infra/datasources/i_auth_datasource.dart';
import '../../presentation/graphql/mutations/auth_mutations.dart';
import '../../presentation/routes/auth_routes.dart';

class AuthDatasource extends IAuthDatasource {
  final IHttpDriver client;
  final IGraphQlDriver graphQlClient;
  final ILocalUserUsecase localUserUsecase;
  final IFirebaseAuthDriver firebaseAuthDriver;

  AuthDatasource({
    required this.client,
    required this.localUserUsecase,
    required this.firebaseAuthDriver,
    required this.graphQlClient,
  });

  @override
  bool sessionIsValid(SessionEntity session) {
    try {
      return session.claims.customerId.isNotEmpty &&
          session.customer.id.isNotEmpty &&
          session.externalUser.token.isNotEmpty &&
          session.user.customerId.isNotEmpty &&
          session.token.accessToken.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<HttpDriverResponse, ExternalUserEntity>> createExternalUser({
    required UserEntity user,
  }) async {
    final response = await client.post(
      'user/external',
      data: UserModel.fromEntity(user).toMap,
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          return Right(ExternalUserModel.fromMap(r.data));
        } catch (e, s) {
          return Left(
            HttpDriverResponse(data: e, statusMessage: s.toString()),
          );
        }
      },
    );
  }

  @override
  Future<Either<HttpDriverResponse, ExternalUserEntity>> refreshToken({
    required String phone,
    required String password,
  }) async {
    final response = await client.post(
      'user/external/session',
      data: {'phone': phone, 'password': password},
    );
    return response.fold(
      (l) => Left(l),
      (r) {
        try {
          return Right(ExternalUserModel.fromMap(r.data));
        } catch (e, s) {
          return Left(
            HttpDriverResponse(data: e, statusMessage: s.toString()),
          );
        }
      },
    );
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> refreshFirebaseToken({
    required String refreshToken,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: AuthMutations.renewAccessToken,
        variables: {'refreshToken': refreshToken},
        options: GraphQlDriverOptions(operationName: 'renewAccessToken'),
      ),
    );
    return response.fold((l) => Left(HttpDriverResponse(data: l.message)), (r) {
      try {
        return Right(TokenModel.fromMap(r.data['renewAccessToken']));
      } catch (e) {
        return Left(HttpDriverResponse(data: e));
      }
    });
  }

  @override
  Future<Either<Exception, Unit>> firebaseSignIn({required String token}) {
    return firebaseAuthDriver.signInWithCustomToken(token: token);
  }

  @override
  Future<Either<Exception, Unit>> logout({bool navigateToLogin = true}) async {
    return localUserUsecase.removeSession().then((value) {
      return firebaseAuthDriver.logout().then((value) {
        return value.fold((l) => Left(l), (r) {
          if (navigateToLogin) {
            Nav.to.pushNamedAndRemoveUntil(
              AuthRoutes.root,
              ModalRoute.withName(AuthRoutes.root.completePath),
            );
          }
          return Right(unit);
        });
      });
    });
  }
}
