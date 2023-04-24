import 'package:core/core.dart';

import '../../infra/datasources/i_user_datasource.dart';
import '../../presentation/graphql/mutations/customer_mutations.dart';

class UserDatasource extends IUserDatasource {
  UserDatasource({
    required this.graphQlClient,
    required this.firebaseAuthDriver,
  });

  final IGraphQlDriver graphQlClient;
  final IFirebaseAuthDriver firebaseAuthDriver;

  @override
  Future<Either<Exception, CustomerEntity>> getUserById({
    required String id,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: CustomerMutations.getCustomer,
        variables: {'id': id},
        options: GraphQlDriverOptions(operationName: 'getCustomer'),
      ),
    );
    return response.fold(
      (l) => Left(Exception(l)),
      (r) {
        try {
          return Right(CustomerModel.fromMap(r.data['getCustomer']));
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }

  @override
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseUser({
    bool forceRefresh = false,
  }) {
    return firebaseAuthDriver.getFirebaseTokenResult(forceRefresh: false);
  }

  @override
  Future<Either<Exception, CustomerEntity>> updateUser({
    required CustomerEntity customer,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: CustomerMutations.updateCustomer,
        variables: {
          'id': customer.id,
          'params': CustomerModel.fromEntity(customer).toUpdateCustomerMap
        },
        options: GraphQlDriverOptions(operationName: 'updateCustomer'),
      ),
    );

    return response.fold(
      (l) => Left(Exception(l)),
      (r) {
        try {
          return Right(CustomerModel.fromMap(r.data['updateCustomer']));
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
