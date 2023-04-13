import 'package:graphql_flutter/graphql_flutter.dart';

import '../../domain/interfaces/either.dart';
import '../interfaces/i_graphql_interceptor.dart';

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
  final String? operationName;
  final String accessTokenType;
  final ContentType contentType;
  final AccessToken? accessToken;
  final Map<String, dynamic>? extraHeaders;

  GraphQlDriverOptions({
    this.baseUrl,
    this.accessToken,
    this.operationName,
    this.extraHeaders,
    this.accessTokenType = 'Bearer',
    this.contentType = 'application/json',
  });

  GraphQlDriverOptions copyWith({
    BaseUrl? baseUrl,
    String? operationName,
    String? accessTokenType,
    ContentType? contentType,
    AccessToken? accessToken,
    Map<String, dynamic>? extraHeaders,
  }) {
    return GraphQlDriverOptions(
      baseUrl: baseUrl ?? this.baseUrl,
      operationName: operationName ?? this.operationName,
      accessTokenType: accessTokenType ?? this.accessTokenType,
      contentType: contentType ?? this.contentType,
      accessToken: accessToken ?? this.accessToken,
      extraHeaders: extraHeaders ?? this.extraHeaders,
    );
  }
}

typedef AccessToken = String;
typedef ContentType = String;
typedef CustomerId = String Function();
typedef BaseUrl = String Function();
typedef CallbackType<T> = T Function();

class GraphRequestData {
  final String document;
  final GraphQlDriverOptions? options;
  final Map<String, dynamic>? variables;

  GraphRequestData({
    required this.document,
    this.options,
    this.variables,
  });

  GraphRequestData copyWith({
    String? document,
    GraphQlDriverOptions? options,
    Map<String, dynamic>? variables,
  }) {
    return GraphRequestData(
      document: document ?? this.document,
      options: options ?? this.options,
      variables: variables ?? this.variables,
    );
  }
}

abstract class IGraphQlDriver {
  Future<Either<GraphQLResponseError, GraphQLResponse>> request({
    required GraphRequestData data,
  });

  final interceptors = List<IGraphQlInterceptor>.empty(growable: true);
}
