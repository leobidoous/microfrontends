import 'package:core/core.dart';

import '../../../infra/datasources/auth/logout_datasource.dart';

class LogoutDatasource extends ILogoutDatasource {
  final ILocalUserUsecase usecase;

  LogoutDatasource({required this.usecase});

  @override
  Future<Either<Exception, Unit>> call() async {
    return await usecase.removeToken().then((value) {
      return value.fold((l) => Left(l), (r) async {
        return usecase.removeLocalUser();
      });
    });
  }
}
