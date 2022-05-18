import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_phone_entity.dart';

abstract class IRemoteLoginWithPhoneDatasource {
  Future<Either<Exception, Unit>> call({
    required LoginWithPhoneEntity login,
  });
}
