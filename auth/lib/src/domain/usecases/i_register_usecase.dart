import 'package:core/core.dart';

import '../failures/register_failure.dart';

abstract class IRegisterUsecase {
  Future<Either<IRegisterFailure, Unit>> onRequestEmailCode();
  Future<Either<IRegisterFailure, Unit>> onValidateEmailCode({
    required String token,
  });
  Future<Either<IRegisterFailure, Unit>> onValidateCpfAlreadyExists({
    required String cpf,
  });
  Future<Either<IRegisterFailure, Unit>> onStartRegister({
    required String phone,
    required String name,
    required String cpf,
  });
  Future<Either<IRegisterFailure, Unit>> onFinishRegister({
    required CustomerEntity customer,
  });
}
