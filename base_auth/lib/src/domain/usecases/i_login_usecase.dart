import 'package:core/core.dart';

import '../failures/login/login_failure.dart';

abstract class ILoginUsecase {
  Future<Either<ILoginFailure, Unit>> onRequestCode({required String phone});
  Future<Either<ILoginFailure, TokenEntity>> onValidateCode({
    required String phone,
    required String code,
  });
}
