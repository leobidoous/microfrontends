import 'dart:developer';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/i_auth_usecase.dart';

class GraphQlAuthInterceptor extends GraphQlInterceptor {
  static final GraphQlAuthInterceptor _singleton =
      GraphQlAuthInterceptor._internal();
  GraphQlAuthInterceptor._internal();

  factory GraphQlAuthInterceptor({
    required IAuthUsecase authUsecase,
    required ILocalUserUsecase localUserUsecase,
  }) {
    _authUsecase = authUsecase;
    _localUserUsecase = localUserUsecase;
    return _singleton;
  }

  static late IAuthUsecase _authUsecase;
  static late ILocalUserUsecase _localUserUsecase;

  @override
  Future<GraphQlDriverOptions> onRequest({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
  }) async {
    log('Operation Name: ${requestData.options?.operationName}');
    return _localUserUsecase.getSession().then((value) {
      return value.fold(
        (l) => super.onRequest(options: options, requestData: requestData),
        (session) async {
          if (!(options.extraHeaders?.keys.any((h) => h == 'Authorization') ??
              false)) {
            debugPrint('GraphQlAuthInterceptor => ADDING TOKEN...');
            options = options.copyWith(
              extraHeaders: options.extraHeaders ?? {},
              accessToken: session.token.accessToken,
            );
            options.extraHeaders!.addAll(
              {
                'Authorization':
                    '${options.accessTokenType} ${session.token.accessToken}',
              },
            );
          }
          return super.onRequest(options: options, requestData: requestData);
        },
      );
    });
  }

  @override
  Future<Either<GraphQLResponseError, GraphQLResponse>> onError({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
    required GraphQLResponseError error,
  }) async {
    final errors = error.exception?.graphqlErrors
        .map((error) => error.message)
        .toList()
        .join('\n');

    log('onError: $errors');
    final hasAuthorization = error.exception!.graphqlErrors.every(
      (e) => e.message.toLowerCase() != 'unauthorized',
    );
    final statusCode = hasAuthorization ? 200 : 401;
    switch (statusCode) {
      case 401:
        final responseUser = await _localUserUsecase.getSession();
        return responseUser.fold(
          (l) async {
            await _finishSession();
            return super.onError(
              error: error,
              options: options,
              requestData: requestData,
            );
          },
          (session) async {
            debugPrint('GraphQlAuthInterceptor => REFRESHING TOKEN...');
            final responseToken = await _authUsecase.refreshFirebaseToken(
              refreshToken: session.token.refreshToken,
            );
            return responseToken.fold(
              (l) async {
                await _finishSession();
                return super.onError(
                  error: error,
                  options: options,
                  requestData: requestData,
                );
              },
              (token) async {
                options.extraHeaders?.addAll(
                  {
                    'Authorization':
                        '${options.accessTokenType} ${token.accessToken}',
                  },
                );
                options = options.copyWith(accessToken: token.accessToken);
                final response = await _getResponse(
                  requestData: requestData,
                  options: options,
                );
                return response.fold(
                  (l) async {
                    if (statusCode == 401) await _finishSession();
                    return super.onError(
                      error: error,
                      options: options,
                      requestData: requestData,
                    );
                  },
                  (response) async {
                    final responseToken = await _localUserUsecase.setSession(
                      session: SessionModel.fromEntity(session).copyWith(
                        token: token,
                      ),
                    );
                    return responseToken.fold(
                      (l) => super.onError(
                        error: error,
                        options: options,
                        requestData: requestData,
                      ),
                      (r) => Right(response),
                    );
                  },
                );
              },
            );
          },
        );
      default:
        return super.onError(
          error: error,
          options: options,
          requestData: requestData,
        );
    }
  }

  Future<void> _finishSession() async {
    await CustomDialog.show(
      Nav.to.context!,
      CustomAlert.serverError(Nav.to.context!),
      showClose: true,
    ).whenComplete(() => _authUsecase.logout());
  }

  Future<Either<GraphQLResponseError, GraphQLResponse>> _getResponse({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
  }) async {
    final client = DM.i.get<GraphQlClientDriver>();
    requestData = requestData.copyWith(options: options);
    return client.request(data: requestData);
  }
}
