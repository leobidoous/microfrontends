import 'package:core/core.dart';

import '../../domain/failures/register_failure.dart';
import '../../infra/datasources/i_register_datasource.dart';
import '../../presentation/graphql/mutations/register_mutations.dart';
import '../../presentation/graphql/queries/register_queries.dart';

class RegisterDatasource extends IRegisterDatasource {
  final IGraphQlDriver graphQlClient;

  RegisterDatasource({required this.graphQlClient});

  @override
  Future<Either<IRegisterFailure, Unit>> onFinishRegister({
    required CustomerEntity customer,
    required String accessToken,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: RegisterMutations.finishCustomerOnboarding,
        variables: {
          'params': CustomerModel.fromEntity(customer).toNewCustomerMap
        },
        options: GraphQlDriverOptions(
          accessToken: accessToken,
          operationName: 'finishCustomerOnboarding',
        ),
      ),
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
          growable: true,
        );
        return Left(
          UnknowError(
            'Ocorreu um erro inesperado',
            detailsMessage: errors.map((e) => e.message).join('\n'),
          ),
        );
      },
      (r) => Right(unit),
    );
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onRequestEmailCode({
    String? accessToken,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: RegisterMutations.sendCustomerEmailVerificationCode,
        options: GraphQlDriverOptions(
          accessToken: accessToken,
          operationName: 'sendCustomerEmailVerificationCode',
        ),
      ),
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
          growable: true,
        );
        return Left(
          UnknowError(
            'Erro ao enviar o código',
            detailsMessage: errors.map((e) => e.message).join('\n'),
          ),
        );
      },
      (r) {
        try {
          final bool hasSuccess = r.data['sendCustomerEmailVerificationCode'];
          if (hasSuccess) return Right(unit);

          return Left(
            SendCodeError(
              'Erro ao enviar o código',
              detailsMessage: 'Não foi possível enviar o código de validação',
            ),
          );
        } catch (e) {
          return Left(UnknowError(e.toString()));
        }
      },
    );
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onStartRegister({
    required String phone,
    required String name,
    required String cpf,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: RegisterMutations.startCustomerOnboarding,
        variables: {
          'phoneNumber': '+55${phone.replaceAll(RegExp(r'[^0-9]'), '')}',
          'name': name,
          'cpf': cpf,
        },
        options: GraphQlDriverOptions(operationName: 'startCustomerOnboarding'),
      ),
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
        );
        if (errors.any(
          (e) => e.message.contains(
            'Faça login no aplicativo utilizando o número *****-0024',
          ),
        )) {
          return Left(
            PhoneAlreadyExist(
              'Conta já cadastrada',
              detailsMessage: errors.map((e) => e.message).join('\n'),
            ),
          );
        } else if (errors
            .any((e) => e.message.contains('Não foi possível enviar a SMS'))) {
          return Left(
            InvalidCodeError(
              'Número inválido',
              detailsMessage: errors.map((e) => e.message).join('\n'),
            ),
          );
        }
        return Left(
          UnknowError(
            'Ocorreu um erro inesperado',
            detailsMessage: errors.map((e) => e.message).join('\n'),
          ),
        );
      },
      (r) => Right(unit),
    );
  }

  @override
  Future<Either<IRegisterFailure, bool>> onValidateCpfAlreadyExists({
    required String cpf,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        variables: {'cpf': cpf},
        document: RegisterQueries.customerAlreadyExists,
        options: GraphQlDriverOptions(operationName: 'customerAlreadyExists'),
      ),
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
          growable: true,
        );
        return Left(
          UnknowError(
            'Ocorreu um erro ao validar seu CPF',
            detailsMessage: errors.map((e) => e.message).join('\n'),
          ),
        );
      },
      (r) {
        try {
          final bool cpfAlreadyExists = r.data['customerAlreadyExists'];
          if (cpfAlreadyExists) {
            return Left(
              CpfAlreadyExist(
                'Conta já cadastrada',
                detailsMessage: '',
              ),
            );
          }
          return Right(cpfAlreadyExists);
        } catch (e) {
          return Left(UnknowError(e.toString()));
        }
      },
    );
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onValidateEmailCode({
    required String token,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: RegisterMutations.validateCustomerEmailVerificationCode,
        variables: {'token': token},
        options: GraphQlDriverOptions(
          operationName: 'validateCustomerEmailVerificationCode',
        ),
      ),
    );
    return response.fold(
      (l) {
        final errors = List<GraphQLError>.from(
          l.exception?.graphqlErrors ?? [],
          growable: true,
        );
        return Left(
          UnknowError(
            'Não foi possível validar o código',
            detailsMessage: errors.map((e) => e.message).join('\n'),
          ),
        );
      },
      (r) => Right(unit),
    );
  }

  @override
  Future<Either<IRegisterFailure, String>> onValidatePhoneCode({
    required String phone,
    required String code,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: RegisterMutations.validateVerificationCode,
        variables: {
          'phoneNumber': '+55${phone.replaceAll(RegExp(r'[^0-9]'), '')}',
          'code': code,
        },
        options: GraphQlDriverOptions(
          operationName: 'validateVerificationCode',
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
          return Right(r.data['validateVerificationCode']);
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
