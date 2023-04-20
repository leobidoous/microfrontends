import 'package:core/core.dart';

import '../../domain/failures/login_failure.dart';
import '../../infra/datasources/i_login_datasource.dart';
import '../../presentation/graphql/mutations/auth_mutations.dart';

class LoginDatasource extends ILoginDatasource {
  final IGraphQlDriver graphQlClient;

  LoginDatasource({required this.graphQlClient});

  @override
  Future<Either<ILoginFailure, Unit>> onRequestPhoneCode({
    required String phone,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: AuthMutations.sendVerificationCode,
        variables: {
          'phoneNumber': '+55${phone.replaceAll(RegExp(r'[^0-9]'), '')}',
          'platform': 'B2C',
        },
        options: GraphQlDriverOptions(operationName: 'sendVerificationCode'),
      ),
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
              '''Não achamos uma conta associada o numero +55$phone''',
              detailsMessage: errors.map((e) => e.message).join('\n'),
            ),
          );
        }
        return Left(
          UnknowError(
            'Erro na solicitação do código',
            detailsMessage: errors.map((e) => e.message).join('\n'),
          ),
        );
      },
      (r) => Right(unit),
    );
  }

  @override
  Future<Either<ILoginFailure, TokenEntity>> onValidatePhoneCode({
    required String phone,
    required String code,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: AuthMutations.validateVerificationCodeFirebase,
        variables: {
          'phoneNumber': '+55${phone.replaceAll(RegExp(r'[^0-9]'), '')}',
          'code': code,
          'platform': 'B2C',
        },
        options: GraphQlDriverOptions(
          operationName: 'validateVerificationCodeFirebase',
        ),
      ),
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
          growable: true,
        );
        if (errors.any(
          (err) => err.message.contains('Código de verificação inválido'),
        )) {
          return Left(
            InvalidCodeError(
              'Erro na verificação do código',
              detailsMessage: errors.map((e) => e.message).join('\n'),
            ),
          );
        }
        return Left(
          UnknowError(
            l.message,
            detailsMessage: errors.map((e) => e.message).join('\n'),
          ),
        );
      },
      (r) {
        try {
          return Right(
            TokenModel.fromMap(r.data['validateVerificationCodeFirebase']),
          );
        } catch (e) {
          return Left(
            UnknowError(
              'Erro na verificação do código',
              detailsMessage: e.toString(),
            ),
          );
        }
      },
    );
  }
}
