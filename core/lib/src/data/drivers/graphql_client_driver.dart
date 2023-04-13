import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/entities/session_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/usecases/i_local_user_usecase.dart';
import '../../infra/drivers/i_graphql_driver.dart';
import '../../infra/models/session_model.dart';

class GraphQlClientDriver extends IGraphQlDriver with Disposable {
  GraphQlClientDriver({
    required this.client,
    required this.baseUrl,
    required this.localUserUsecase,
  });

  final String baseUrl;
  final GraphQLClient client;
  final ILocalUserUsecase localUserUsecase;

  @override
  Future<Either<GraphQLResponseError, GraphQLResponse>> request({
    required String document,
    String? operationName,
    GraphQlDriverOptions? options,
    Map<String, dynamic>? variables,
  }) async {
    final opt = options ?? GraphQlDriverOptions(baseUrl: () => baseUrl);

    try {
      final mutationOptions = MutationOptions(
        document: gql(document),
        variables: variables ?? {},
        operationName: operationName,
      );
      late final GraphQLClient newClient;
      if (interceptor != null) {
        await interceptor
            ?.onRequest(client: client, options: opt)
            .then((value) {
          value.fold((l) => newClient = client, (r) => newClient = r);
        });
      } else {
        final httpLink = HttpLink(
          opt.baseUrl?.call() ?? baseUrl,
          parser: const ResponseParser(),
          serializer: const RequestSerializer(),
          defaultHeaders: {
            'Content-Type': opt.contentType,
            if (opt.extraHeaders != null) ...opt.extraHeaders!,
          },
        );

        final authLink = AuthLink(
          getToken: () => '${opt.accessTokenType} ${opt.accessToken}',
        );
        newClient = client.copyWith(link: authLink.concat(httpLink));
      }
      final result = await newClient.mutate(mutationOptions);
      if (result.hasException) {
        final hasAuthorization = result.exception!.graphqlErrors.every(
          (e) => e.message.toLowerCase() != 'unauthorized',
        );
        if (!hasAuthorization) {
          final sessionResponse = await localUserUsecase.getSession();
          return sessionResponse.fold(
            (l) async {
              await _finishSession();
              return Left(GraphQLResponseError(message: l.toString()));
            },
            (session) {
              return _refreshToken(options: opt, session: session)
                  .then((value) {
                return value.fold(
                  (l) async {
                    await _finishSession();
                    return Left(GraphQLResponseError(message: l.toString()));
                  },
                  (options) => request(
                    options: options,
                    document: document,
                    variables: variables,
                    operationName: operationName,
                  ),
                );
              });
            },
          );
        }
        return Left(
          GraphQLResponseError(
            message: result.exception.toString(),
            exception: result.exception,
            source: result.source,
          ),
        );
      }
      return Right(GraphQLResponse(data: result.data ?? {}));
    } on Exception catch (e) {
      return Left(GraphQLResponseError(message: e.toString()));
    }
  }

  Future<Either<Exception, GraphQlDriverOptions>> _refreshToken({
    required GraphQlDriverOptions options,
    required SessionEntity session,
  }) async {
    debugPrint('GraphQlInterceptor => REFRESHING TOKEN...');
    final authUsecase = DM.i.get<AuthUsecase>();
    final tokenResponse = await authUsecase.refreshFirebaseToken(
      refreshToken: session.token.refreshToken,
    );
    return tokenResponse.fold(
      (l) => Left(Exception(l)),
      (token) {
        return localUserUsecase
            .setSession(
          session: SessionModel.fromEntity(session).copyWith(
            token: token,
          ),
        )
            .then(
          (value) {
            return value.fold(
              (l) => Left(l),
              (r) {
                return Right(
                  GraphQlDriverOptions(
                    baseUrl: options.baseUrl,
                    accessTokenType: options.accessTokenType,
                    contentType: options.contentType,
                    accessToken: token.accessToken,
                    extraHeaders: options.extraHeaders,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _finishSession() async {
    await GenDialog.show(
      Nav.to.context,
      GenAlert.serverError(Nav.to.context),
      showClose: true,
    ).whenComplete(
      () async {
        final globalAuthController = DM.i.get<GlobalAuthController>();
        await globalAuthController.signOut();
        
      },
    );
  }

  @override
  FutureOr onDispose() {
    client.link.dispose();
  }
}
