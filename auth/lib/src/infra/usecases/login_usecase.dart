import 'package:core/core.dart';

import '../../domain/failures/login/login_failure.dart';
import '../../domain/repositories/i_login_repository.dart';
import '../../domain/usecases/i_login_usecase.dart';

class LoginUsecase extends ILoginUsecase {
  final ILoginRepository repository;

  LoginUsecase({required this.repository});

  @override
  Future<Either<ILoginFailure, Unit>> onRequestCode({required String phone}) {
    return repository.onRequestCode(phone: phone);
  }

  @override
  Future<Either<ILoginFailure, TokenEntity>> onValidateCode({
    required String phone,
    required String code,
  }) {
    return repository.onValidateCode(code: code, phone: phone);
  }
}
