import 'package:core/core.dart';

import '../failures/register_failure.dart';

abstract class IRegisterRepository {
  Future<Either<IRegisterFailure, Unit>> onRequestEmailCode({
    String? accessToken,
  });
  Future<Either<IRegisterFailure, Unit>> onValidateEmailCode({
    required String token,
  });
  Future<Either<IRegisterFailure, bool>> onValidateCpfAlreadyExists({
    required String cpf,
  });
  Future<Either<IRegisterFailure, String>> onValidatePhoneCode({
    required String phone,
    required String code,
  });
  Future<Either<IRegisterFailure, Unit>> onStartRegister({
    required String phone,
    required String name,
    required String cpf,
  });
  Future<Either<IRegisterFailure, Unit>> onFinishRegister({
    required CustomerEntity customer,
    required String accessToken,
  });
}
