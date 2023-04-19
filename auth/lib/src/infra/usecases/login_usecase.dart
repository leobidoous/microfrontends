import 'package:core/core.dart';

import '../../domain/failures/login_failure.dart';
import '../../domain/repositories/i_login_repository.dart';
import '../../domain/usecases/i_login_usecase.dart';

class LoginUsecase extends ILoginUsecase {
  final ILoginRepository repository;

  LoginUsecase({required this.repository});

  @override
  Future<Either<ILoginFailure, Unit>> onRequestPhoneCode({
    required String phone,
  }) {
    return repository.onRequestPhoneCode(phone: phone);
  }

  @override
  Future<Either<ILoginFailure, TokenEntity>> onValidatePhoneCode({
    required String phone,
    required String code,
  }) {
    return repository.onValidatePhoneCode(code: code, phone: phone);
  }
}
