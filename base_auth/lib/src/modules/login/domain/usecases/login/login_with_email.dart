import 'package:core/core.dart';

import '../../entities/login/login_with_email_entity.dart';
import '../../repositories/login/login_with_email_repository.dart';

abstract class ILoginWithEmailUsecase {
  Future<Either<Exception, Object>> call({required LoginWithEmailEntity login});
}

class LoginWithEmailUsecase extends ILoginWithEmailUsecase {
  final ILoginWithEmailRepository repository;

  LoginWithEmailUsecase({required this.repository});

  @override
  Future<Either<Exception, Object>> call({
    required LoginWithEmailEntity login,
  }) {
    return repository(login: login);
  }
}
