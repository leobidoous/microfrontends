import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/firebase_token_result_entity.dart';
import '../../domain/interfaces/either.dart';

abstract class IUserDatasource {
  Future<Either<Exception, CustomerEntity>> getUserById({required String id});
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseUser({
    bool forceRefresh = false,
  });
}
