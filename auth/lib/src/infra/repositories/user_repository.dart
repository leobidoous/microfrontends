import 'package:core/core.dart';

import '../../domain/repositories/i_user_repository.dart';
import '../datasources/i_user_datasource.dart';

class UserRepository extends IUserRepository {
  final IUserDatasource datasource;

  UserRepository({required this.datasource});

  @override
  Future<Either<Exception, CustomerEntity>> getUserById({required String id}) {
    return datasource.getUserById(id: id);
  }

  @override
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseUser({
    bool forceRefresh = false,
  }) {
    return datasource.getFirebaseUser(forceRefresh: forceRefresh);
  }

  @override
  Future<Either<Exception, CustomerEntity>> updateUser({
    required CustomerEntity customer,
  }) {
    return datasource.updateUser(customer: customer);
  }
}
