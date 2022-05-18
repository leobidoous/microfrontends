import 'package:core/core.dart';

import '../../domain/repositories/logged_user_repository.dart';
import '../datasources/logged_user_datasource.dart';

class LoggedUserRepository extends ILoggedUserRepository {
  final ILoggedUserDatasource datasource;

  LoggedUserRepository({required this.datasource});

  @override
  Future<Either<Exception, LoggedUserEntity>> getLoggedUser() {
    return datasource.getLoggedUser();
  }

  @override
  Future<Either<Exception, Unit>> saveLoggedUser({
    required LoggedUserEntity user,
  }) {
    return datasource.saveLoggedUser(user: user);
  }

  @override
  Future<Either<Exception, Unit>> removeLoggedUser() {
    return datasource.removeLoggedUser();
  }
}
