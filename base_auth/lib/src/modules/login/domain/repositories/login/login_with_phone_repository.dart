import 'package:core/core.dart';

import '../../entities/login/login_with_phone_entity.dart';

abstract class ILoginWithPhoneRepository {
  Future<Either<Exception, Unit>> call({required LoginWithPhoneEntity login});
}
