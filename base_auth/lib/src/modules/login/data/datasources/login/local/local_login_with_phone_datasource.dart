import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_phone_entity.dart';
import '../../../../infra/datasources/login/local/local_login_with_phone_datasource.dart';

class LocalLoginWithPhoneDatasource extends ILocalLoginWithPhoneDatasource {
  @override
  Future<Either<Exception, Unit>> call({
    required LoginWithPhoneEntity login,
  }) {
    throw UnimplementedError();
  }
}
