import 'package:core/core.dart';

import '../../domain/failures/register_failure.dart';
import '../../domain/repositories/i_register_repository.dart';
import '../datasources/i_register_datasource.dart';

class RegisterRepository extends IRegisterRepository {
  final IRegisterDatasource datasource;

  RegisterRepository({required this.datasource});

  @override
  Future<Either<IRegisterFailure, Unit>> onFinishRegister({
    required CustomerEntity customer,
    required String accessToken,
  }) {
    return datasource.onFinishRegister(
      customer: customer,
      accessToken: accessToken,
    );
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onRequestEmailCode({
    String? accessToken,
  }) {
    return datasource.onRequestEmailCode(accessToken: accessToken);
  }

  @override
  Future<Either<IRegisterFailure, TokenEntity>> onValidatePhoneCode({
    required String phone,
    required String code,
  }) {
    return datasource.onValidatePhoneCode(phone: phone, code: code);
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onStartRegister({
    required String phone,
    required String name,
    required String cpf,
  }) {
    return datasource.onStartRegister(
      phone: phone,
      name: name,
      cpf: cpf,
    );
  }

  @override
  Future<Either<IRegisterFailure, bool>> onValidateCpfAlreadyExists({
    required String cpf,
  }) {
    return datasource.onValidateCpfAlreadyExists(cpf: cpf);
  }

  @override
  Future<Either<IRegisterFailure, Unit>> onValidateEmailCode({
    required String token,
  }) {
    return datasource.onValidateEmailCode(token: token);
  }
}
