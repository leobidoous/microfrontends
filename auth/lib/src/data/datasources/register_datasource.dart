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
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: RegisterMutations.finishCustomerOnboarding,
        variables: CustomerModel.fromEntity(customer).toNewCustomerMap,
        options: GraphQlDriverOptions(
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
        return Left(UnknowError(errors.join('\n')));
      },
      (r) => Right(unit),
    );
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onRequestEmailCode() async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: RegisterMutations.sendCustomerEmailVerificationCode,
        options: GraphQlDriverOptions(
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
        return Left(UnknowError(errors.join('\n')));
      },
      (r) => Right(unit),
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
          growable: true,
        );
        return Left(UnknowError(errors.join('\n')));
      },
      (r) => Right(unit),
    );
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onValidateCpfAlreadyExists({
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
        return Left(UnknowError(errors.join('\n')));
      },
      (r) => Right(unit),
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
        return Left(UnknowError(errors.join('\n')));
      },
      (r) => Right(unit),
    );
  }
}
