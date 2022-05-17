import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_phone_entity.dart';

abstract class ILocalLoginWithPhoneDatasource {
  Future<Either<Exception, Object>> call({
    required LoginWithPhoneEntity login,
  });
}
