import 'package:core/core.dart';

import '../../../domain/entities/login/login_with_phone_entity.dart';
import '../../../domain/repositories/login/login_with_phone_repository.dart';
import '../../datasources/login/local/local_login_with_phone_datasource.dart';
import '../../datasources/login/remote/remote_login_with_phone_datasource.dart';

class LoginWithPhoneRepository extends ILoginWithPhoneRepository {
  final IRemoteLoginWithPhoneDatasource remoteDatasource;
  final ILocalLoginWithPhoneDatasource localDatasource;
  final IConnectivityService connectivityService;

  LoginWithPhoneRepository({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.connectivityService,
  });

  @override
  Future<Either<Exception, Object>> call({
    required LoginWithPhoneEntity login,
  }) async {
    final isOnline = await connectivityService.isOnline();
    return isOnline.fold(
      (l) => localDatasource(login: login),
      (r) => remoteDatasource(login: login),
    );
  }
}
