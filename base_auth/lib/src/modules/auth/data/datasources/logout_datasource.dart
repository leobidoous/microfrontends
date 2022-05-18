import 'package:core/core.dart';

import '../../infra/datasources/logged_user_datasource.dart';
import '../../infra/datasources/logout_datasource.dart';

class LogoutDatasource extends ILogoutDatasource {
  final ILoggedUserDatasource datasource;

  LogoutDatasource({required this.datasource});

  @override
  Future<Either<Exception, Unit>> call() async {
    return datasource.removeLoggedUser();
  }
}
