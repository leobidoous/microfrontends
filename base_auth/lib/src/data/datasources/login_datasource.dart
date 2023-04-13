import 'package:core/core.dart' hide ServerError, UnknowError;

import '../../domain/failures/login/login_failure.dart';
import '../../infra/datasources/i_login_datasource.dart';
import '../../presentation/graphql/mutations/auth_mutations.dart';

class LoginDatasource extends ILoginDatasource {
  final IGraphQlDriver graphQlClient;

  LoginDatasource({required this.graphQlClient});

  @override
  Future<Either<ILoginFailure, Unit>> onRequestCode({
    required String phone,
  }) async {
    final response = await graphQlClient.request(
      document: AuthMutations.sendVerificationCode,
      variables: {
        'phoneNumber': '+55${phone.replaceAll(RegExp(r'[^0-9]'), '')}',
        'platform': 'B2C',
      },
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
          growable: true,
        );
        if (errors.any(
          (err) => err.message.contains(
            '''Não identificamos o número informado, crie sua conta para realizar login no aplicativo''',
          ),
        )) {
          return Left(
            AccountNotExist(
              '''Não identificamos o número informado, crie sua conta para realizar login no aplicativo''',
            ),
          );
        }
        return Left(UnknowError(l.message));
      },
      (r) => Right(unit),
    );
  }

  @override
  Future<Either<ILoginFailure, TokenEntity>> onValidateCode({
    required String phone,
    required String code,
  }) async {
    final response = await graphQlClient.request(
      document: AuthMutations.validateVerificationCodeFirebase,
      variables: {
        'phoneNumber': '+55${phone.replaceAll(RegExp(r'[^0-9]'), '')}',
        'code': code,
        'platform': 'B2C',
      },
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
          growable: true,
        );
        if (errors.any(
          (err) => err.message.contains('''Código de verificação inválido'''),
        )) {
          return Left(
            InvalidCodeError(
              '''Código de verificação inválido''',
            ),
          );
        } else if (l.message.contains('')) {
          return Left(UnknowError(l.message));
        }
        return Left(UnknowError(l.message));
      },
      (r) {
        try {
          return Right(
            TokenModel.fromMap(r.data['validateVerificationCodeFirebase']),
          );
        } catch (e) {
          return Left(UnknowError(e.toString()));
        }
      },
    );
  }
}
