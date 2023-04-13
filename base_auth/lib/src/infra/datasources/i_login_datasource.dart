
import 'package:core/core.dart';

import '../../domain/failures/login/login_failure.dart';

abstract class ILoginDatasource {
  Future<Either<ILoginFailure, Unit>> onRequestCode({required String phone});
  Future<Either<ILoginFailure, TokenEntity>> onValidateCode({
    required String phone,
    required String code,
  });
}
