import '../../domain/interfaces/either.dart';
import '../drivers/i_graphql_driver.dart';

abstract class IGraphQlInterceptor {
  Future<GraphQlDriverOptions> onRequest({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
  });
  Future<GraphQLResponse> onResponse({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
    required GraphQLResponse response,
  });
  Future<Either<GraphQLResponseError, GraphQLResponse>> onError({
    required GraphRequestData requestData,
    required GraphQlDriverOptions options,
    required GraphQLResponseError error,
  });
}
