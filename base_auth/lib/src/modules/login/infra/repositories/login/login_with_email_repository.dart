import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/login/login_with_email_entity.dart';
import '../../../domain/repositories/login/login_with_email_repository.dart';
import '../../datasources/login/local/local_login_with_email_datasource.dart';
import '../../datasources/login/remote/remote_login_with_email_datasource.dart';

class LoginWithEmailRepository extends ILoginWithEmailRepository {
  final IRemoteLoginWithEmailDatasource remoteDatasource;
  final ILocalLoginWithEmailDatasource localDatasource;
  final IConnectivityService connectivityService;

  LoginWithEmailRepository({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.connectivityService,
  });

  @override
  Future<Either<Exception, Object>> call({
    required LoginWithEmailEntity login,
  }) async {
    final isOnline = await connectivityService.isOnline();
    return isOnline.fold(
      (l) => localDatasource(login: login),
      (r) => remoteDatasource(login: login),
    );
  }
}
