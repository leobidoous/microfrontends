import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/interfaces/either.dart';


class GraphQLResponse {
  final Map<String, dynamic> data;

  GraphQLResponse({this.data = const {}});
}

class GraphQLResponseError {
  final String message;
  final List<ErrorLocation>? locations;
  final List<dynamic /* String | int */ >? path;
  final Map<String, dynamic>? extensions;
  final OperationException? exception;
  final QueryResultSource? source;

  const GraphQLResponseError({
    required this.message,
    this.locations,
    this.path,
    this.extensions,
    this.exception,
    this.source,
  });
}

class GraphQlDriverOptions {
  final BaseUrl? baseUrl;
  final String accessTokenType;
  final ContentType contentType;
  final AccessToken? accessToken;
  final Map<String, dynamic>? extraHeaders;

  GraphQlDriverOptions({
    this.baseUrl,
    this.accessToken,
    this.extraHeaders,
    this.accessTokenType = 'Bearer',
    this.contentType = 'application/json',
  });
}

typedef AccessToken = String;
typedef ContentType = String;
typedef CustomerId = String Function();
typedef BaseUrl = String Function();
typedef CallbackType<T> = T Function();

abstract class IGraphQlDriver {
  Future<Either<GraphQLResponseError, GraphQLResponse>> request({
    required String document,
    String? operationName,
    GraphQlDriverOptions? options,
    Map<String, dynamic>? variables,
  });

  IGraphQlInterceptor? interceptor;
}
