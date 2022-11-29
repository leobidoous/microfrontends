import 'package:core/core.dart' show Either, LoggedUserEntity, Unit;

abstract class ILoggedUserDatasource {
  Future<Either<Exception, LoggedUserEntity>> getSavedUser();
  Future<Either<Exception, Unit>> removeSavedUser();
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  });
}
