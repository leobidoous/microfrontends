import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/firebase_token_result_entity.dart';
import '../../domain/interfaces/either.dart';
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
}