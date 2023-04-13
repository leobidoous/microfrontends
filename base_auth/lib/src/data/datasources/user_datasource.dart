
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
      document: CustomerMutations.getCustomer,
      variables: {'id': id},
      operationName: 'getCustomer',
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
}
