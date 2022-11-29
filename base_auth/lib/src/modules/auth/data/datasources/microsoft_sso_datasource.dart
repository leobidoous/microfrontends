import 'package:core/core.dart'
    show
        Disposable,
        DioClientDriver,
        HttpDriverResponse,
        Either,
        Right,
        Left,
        TokenEntity,
        HttpDriverOptions,
        TokenModel,
        Unit,
        LoggedUserEntity;

import '../../../../core/constants/scope_constants.dart';
import '../../domain/sso_config_entity.dart';
import '../../domain/usecases/logged_user_usecase.dart';
import '../../infra/datasources/microsoft_sso_datasource.dart';

class MicrosoftSSODatasource extends IMicrosoftSSODatasource with Disposable {
  // TODO: Put this on Environment Flavor
  final config = SSOConfigEntity(
    clientId: '',
    tenantId: '',
    clientSecret: '',
    redirectUri: '',
  );

  final DioClientDriver client;
  final ILoggedUserUsecase loggedUserUsecase;

  MicrosoftSSODatasource({
    required this.client,
    required this.loggedUserUsecase,
  });

  @override
  Future<Either<HttpDriverResponse, String>> getAuthorizeUrl() async {
    final urlAuth =
        'https://login.microsoftonline.com/${config.tenantId}/oauth2/v2.0/authorize?'
                'response_type=${config.responseType}&'
                'redirect_uri=${config.redirectUri}&'
                'client_id=${config.clientId}&'
                'scope=${config.scope}'
            .replaceAll(' ', '%20');
    return Right(urlAuth);
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> getToken({
    required String code,
  }) async {
    final response = await client.post(
      'https://login.microsoftonline.com/${config.tenantId}/oauth2/v2.0/token',
      data: {
        'code': code,
        'scope': config.scope,
        'client_id': config.clientId,
        'redirect_uri': config.redirectUri,
        'client_secret': config.clientSecret,
        'grant_type': 'authorization_code',
      },
      options: HttpDriverOptions(
        extraHeaders: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );
    return response.fold(
      (l) => Left(l),
      (r) => Right(TokenModel.fromMap(r.data)),
    );
  }

  @override
  Future<Either<HttpDriverResponse, TokenEntity>> refreshToken({
    required String token,
    String? scope,
  }) async {
    final response = await client.post(
      'https://login.microsoftonline.com/${config.tenantId}/oauth2/v2.0/token',
      data: {
        'scope': scope ?? config.scope,
        'client_id': config.clientId,
        'refresh_token': token,
        'redirect_uri': config.redirectUri,
        'grant_type': 'refresh_token',
        'client_secret': config.clientSecret,
      },
      options: HttpDriverOptions(
        extraHeaders: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    return response.fold(
      (l) => Left(l),
      (r) => Right(TokenModel.fromMap(r.data)),
    );
  }

  @override
  Future<Either<HttpDriverResponse, Unit>> verifyToken({
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<HttpDriverResponse, Unit>> getUserDetails({
    required TokenEntity token,
  }) async {
    final response = await client.get(
      'https://graph.microsoft.com/v1.0/me',
      options: HttpDriverOptions(accessToken: token.accessToken),
    );
    return response.fold(
      (l) => Left(l),
      (r) async => await refreshToken(
        token: token.refreshToken,
        scope: ScopeConstants.blob,
      ).then((value) {
        return value.fold(
          (l) => Left(l),
          (sharepointToken) => response.fold(
            (l) => Left(l),
            (user) async => await loggedUserUsecase
                .saveLoggedUser(
              user: LoggedUserEntity(
                graphToken: token,
                id: user.data['id'],
                mail: user.data['mail'],
                surname: user.data['surname'],
                jobTitle: user.data['jobTitle'],
                sharepointToken: sharepointToken,
                givenName: user.data['givenName'],
                displayName: user.data['displayName'],
                mobilePhone: user.data['mobilePhone'],
                officeLocation: user.data['officeLocation'],
                preferredLanguage: user.data['preferredLanguage'],
                userPrincipalName: user.data['userPrincipalName'],
              ),
            )
                .then((value) {
              return value.fold(
                (l) => Left(
                  HttpDriverResponse(
                    data: '',
                    statusMessage: 'Erro ao criar sessão do usuário',
                  ),
                ),
                (r) => Right(r),
              );
            }),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    client.client.close();
  }
}
