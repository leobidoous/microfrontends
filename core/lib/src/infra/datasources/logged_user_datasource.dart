import '../../../core.dart';

abstract class ILoggedUserDatasource {
  Future<Either<Exception, LoggedUserEntity>> getLoggedUser();
  Future<Either<Exception, Unit>> removeLoggedUser();
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  });
}
