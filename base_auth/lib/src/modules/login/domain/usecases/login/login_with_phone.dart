import 'package:core/core.dart';

import '../../entities/login/login_with_phone_entity.dart';
import '../../repositories/login/login_with_phone_repository.dart';

abstract class ILoginWithPhoneUsecase {
  Future<Either<Exception, Unit>> call({required LoginWithPhoneEntity login});
}

class LoginWithPhoneUsecase extends ILoginWithPhoneUsecase {
  final ILoginWithPhoneRepository repository;

  LoginWithPhoneUsecase({required this.repository});

  @override
  Future<Either<Exception, Unit>> call({
    required LoginWithPhoneEntity login,
  }) {
    return repository(login: login);
  }
}
