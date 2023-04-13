import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/interfaces/either.dart';
import '../../domain/usecases/i_local_user_usecase.dart';
import '../../infra/drivers/i_graphql_driver.dart';

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
            ?.onRequest()
            // ?.onRequest(client: client, options: opt)
            .then((value) {
          value.fold((l) => newClient = client, (r) => null);
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

  @override
  FutureOr onDispose() {
    client.link.dispose();
  }
}
