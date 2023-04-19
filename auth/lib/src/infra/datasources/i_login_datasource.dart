import 'package:core/core.dart';

import '../../domain/failures/login_failure.dart';

abstract class ILoginDatasource {
  Future<Either<ILoginFailure, Unit>> onRequestPhoneCode({
    required String phone,
  });
  Future<Either<ILoginFailure, TokenEntity>> onValidatePhoneCode({
    required String phone,
    required String code,
  });
}
