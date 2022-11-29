import 'package:core/core.dart' show Either, Unit, CookieManager;

import '../../domain/usecases/logged_user_usecase.dart';
import '../../infra/datasources/logout_datasource.dart';

class LogoutDatasource extends ILogoutDatasource {
  final ILoggedUserUsecase usecase;

  LogoutDatasource({required this.usecase});

  @override
  Future<Either<Exception, Unit>> call() async {
    await CookieManager().clearCookies();
    return usecase.removeSavedUser();
  }
}
