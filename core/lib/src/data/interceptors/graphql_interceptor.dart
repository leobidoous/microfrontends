import '../../../core.dart';

class GraphQlInterceptor extends IGraphQlInterceptor {
  // static final GraphQlInterceptor _singleton =
  // GraphQlInterceptor._internal();
  // factory GraphQlInterceptor() => _singleton;
  // GraphQlInterceptor._internal();

  @override
  Future<GraphQlDriverOptions> onRequest({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
  }) async =>
      options;

  @override
  Future<Either<GraphQLResponseError, GraphQLResponse>> onError({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
    required GraphQLResponseError error,
  }) async =>
      Left(error);

  @override
  Future<GraphQLResponse> onResponse({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
    required GraphQLResponse response,
  }) async =>
      response;
}
