import '../entities/customer_entity.dart';
import '../entities/firebase_token_result_entity.dart';
import '../interfaces/either.dart';

abstract class IUserRepository {
  Future<Either<Exception, CustomerEntity>> getUserById({required String id});
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseUser({
    bool forceRefresh = false,
  });
}
