import 'package:core/core.dart';

abstract class IUserDatasource {
  Future<Either<Exception, CustomerEntity>> getUserById({required String id});
  Future<Either<Exception, FirebaseTokenResultEntity>> getFirebaseUser({
    bool forceRefresh = false,
  });
}