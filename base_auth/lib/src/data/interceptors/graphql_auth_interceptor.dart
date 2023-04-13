import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import '../../domain/usecases/i_auth_usecase.dart';

class GraphQlAuthInterceptor extends IGraphQlInterceptor {
  GraphQlAuthInterceptor({
    required this.localUserUsecase,
    required this.authUsecase,
  });

  final IAuthUsecase authUsecase;
  final ILocalUserUsecase localUserUsecase;

  @override
  Future<Either<Exception, GraphQLClient>> onRequest({
    required GraphQLClient client,
    required GraphQlDriverOptions options,
  }) async {
    final httpLink = HttpLink(
      options.baseUrl?.call() ?? '',
      parser: const ResponseParser(),
      serializer: const RequestSerializer(),
      defaultHeaders: {
        'Content-Type': options.contentType,
        if (options.extraHeaders != null) ...options.extraHeaders!,
      },
    );

    late final Link link;
    debugPrint('GraphQlInterceptor => ADDING TOKEN...');
    if (options.accessToken == null) {
      TokenEntity? token;
      final sessionResponse = await localUserUsecase.getSession();
      sessionResponse.fold((l) => null, (r) => token = r.token);
      final authLink = AuthLink(
        getToken: () => '${options.accessTokenType} ${token?.accessToken}',
      );
      link = authLink.concat(httpLink);
    } else {
      final authLink = AuthLink(
        getToken: () => '${options.accessTokenType} ${options.accessToken}',
      );
      link = authLink.concat(httpLink);
    }
    return Right(client.copyWith(link: link));
  }

  @override
  Future<Either<Exception, Unit>> onResponse() async {
    debugPrint('onResponse...');
    return Right(unit);
  }

  @override
  Future<Either<Exception, Unit>> onError() async {
    debugPrint('onError...');
    return Right(unit);
  }
}
