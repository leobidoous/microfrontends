import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_email_entity.dart';
import '../../../../infra/datasources/login/remote/remote_login_with_email_datasource.dart';

class RemoteLoginWithEmailDatasource extends IRemoteLoginWithEmailDatasource {
  @override
  Future<Either<Exception, Object>> call({
    required LoginWithEmailEntity login,
  }) async {
    final response = await LoadMock.fromAsset('login_mock.json');
    return Right(response);
  }
}
