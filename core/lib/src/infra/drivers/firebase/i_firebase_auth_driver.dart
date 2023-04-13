import '../../../domain/entities/customer_entity.dart';
import '../../../domain/entities/firebase_token_result_entity.dart';
import '../../../domain/interfaces/either.dart';

abstract class IFirebaseAuthDriver {
  CustomerEntity? get getCurrentUser;
  Future<Either<Exception, Unit>> logout();
  Future<Either<Exception, Unit>> signInWithCustomToken({
    required String token,
  });
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseTokenResult({
    bool forceRefresh = false,
  });
}
