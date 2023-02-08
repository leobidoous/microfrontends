import 'package:core/core.dart';

import '../../entities/login_email_entity.dart';
import '../../repositories/login/login_with_email_repository.dart';

abstract class ILoginWithEmailUsecase {
  Future<Either<Exception, TokenEntity>> call({required LoginEmailEntity data});
}

class LoginWithEmailUsecase extends ILoginWithEmailUsecase {
  final ILoginWithEmailRepository repository;

  LoginWithEmailUsecase({required this.repository});

  @override
  Future<Either<Exception, TokenEntity>> call({
    required LoginEmailEntity data,
  }) {
    return repository(data: data);
  }
}
