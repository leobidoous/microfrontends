import 'package:core/core.dart';

abstract class ILoggedUserRepository {
  Future<Either<Exception, LoggedUserEntity>> getLoggedUser();
  Future<Either<Exception, Unit>> removeLoggedUser();
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  });
}
