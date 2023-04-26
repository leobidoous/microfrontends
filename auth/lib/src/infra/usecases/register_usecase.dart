import 'package:core/core.dart';

import '../../domain/failures/register_failure.dart';
import '../../domain/repositories/i_register_repository.dart';
import '../../domain/usecases/i_register_usecase.dart';

class RegisterUsecase extends IRegisterUsecase {
  final IRegisterRepository repository;

  RegisterUsecase({required this.repository});

  @override
  Future<Either<IRegisterFailure, Unit>> onFinishRegister({
    required CustomerEntity customer,
    required String accessToken,
  }) {
    return repository.onFinishRegister(
      customer: customer,
      accessToken: accessToken,
    );
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onRequestEmailCode({
    String? accessToken,
  }) {
    return repository.onRequestEmailCode(accessToken: accessToken);
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onStartRegister({
    required String phone,
    required String name,
    required String cpf,
  }) {
    return repository.onStartRegister(
      phone: phone,
      name: name,
      cpf: cpf,
    );
  }

  @override
  Future<Either<IRegisterFailure, bool>> onValidateCpfAlreadyExists({
    required String cpf,
  }) {
    return repository.onValidateCpfAlreadyExists(cpf: cpf);
  }

  @override
  Future<Either<IRegisterFailure, TokenEntity>> onValidatePhoneCode({
    required String phone,
    required String code,
  }) {
    return repository.onValidatePhoneCode(phone: phone, code: code);
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onValidateEmailCode({
    required String token,
  }) {
    return repository.onValidateEmailCode(token: token);
  }
}
