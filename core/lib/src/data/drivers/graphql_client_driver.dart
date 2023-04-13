import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_graphql_driver.dart';
import '../../infra/interfaces/i_graphql_interceptor.dart';

class GraphQlClientDriver extends IGraphQlDriver with Disposable {
  GraphQlClientDriver({
    required this.client,
    required this.baseUrl,
  });

  final String baseUrl;
  final GraphQLClient client;

  @override
  Future<Either<GraphQLResponseError, GraphQLResponse>> request({
    required GraphRequestData data,
  }) async {
    GraphQlDriverOptions opt = data.options ??
        GraphQlDriverOptions(
          baseUrl: () => baseUrl,
          extraHeaders: {},
        );
    try {
      final mutationOptions = MutationOptions(
        document: gql(data.document),
        variables: data.variables ?? {},
        operationName: opt.operationName,
      );

      for (IGraphQlInterceptor interceptor in interceptors) {
        opt = await interceptor.onRequest(options: opt, requestData: data);
      }
      final result = await _getClient(opt).mutate(mutationOptions);
      if (result.hasException) {
        GraphQLResponseError error = GraphQLResponseError(
          message: result.exception.toString(),
          exception: result.exception,
          source: result.source,
        );
        Either<GraphQLResponseError, GraphQLResponse> response = Left(error);
        for (IGraphQlInterceptor interceptor in interceptors) {
          response = await interceptor.onError(
            requestData: data,
            options: opt,
            error: error,
          );
        }
        return response;
      }
      GraphQLResponse response = GraphQLResponse(data: result.data ?? {});
      for (IGraphQlInterceptor interceptor in interceptors) {
        response = await interceptor.onResponse(
          options: opt,
          requestData: data,
          response: response,
        );
      }
      return Right(response);
    } on Exception catch (e) {
      return Left(GraphQLResponseError(message: e.toString()));
    }
  }

  GraphQLClient _getClient(GraphQlDriverOptions options) {
    final httpLink = HttpLink(
      options.baseUrl?.call() ?? baseUrl,
      parser: const ResponseParser(),
      serializer: const RequestSerializer(),
      defaultHeaders: {
        'Content-Type': options.contentType,
        if (options.extraHeaders != null) ...options.extraHeaders!,
      },
    );

    final authLink = AuthLink(
      getToken: () => '${options.accessTokenType} ${options.accessToken}',
    );
    return client.copyWith(link: authLink.concat(httpLink));
  }

  @override
  FutureOr onDispose() {
    client.link.dispose();
  }
}
