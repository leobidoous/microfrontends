import 'package:dartz/dartz.dart';

import '../../../../domain/entities/login/login_with_phone_entity.dart';
import '../../../../infra/datasources/login/remote/remote_login_with_phone_datasource.dart';

class RemoteLoginWithPhoneDatasource extends IRemoteLoginWithPhoneDatasource {
  @override
  Future<Either<Exception, Object>> call({
    required LoginWithPhoneEntity login,
  }) {
    throw UnimplementedError();
  }
}
