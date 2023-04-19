import 'package:core/core.dart';

import '../../domain/failures/login_failure.dart';
import '../../domain/repositories/i_login_repository.dart';
import '../datasources/i_login_datasource.dart';

class LoginRepository extends ILoginRepository {
  final ILoginDatasource datasource;

  LoginRepository({required this.datasource});

  @override
  Future<Either<ILoginFailure, Unit>> onRequestPhoneCode({
    required String phone,
  }) {
    return datasource.onRequestPhoneCode(phone: phone);
  }

  @override
  Future<Either<ILoginFailure, TokenEntity>> onValidatePhoneCode({
    required String phone,
    required String code,
  }) {
    return datasource.onValidatePhoneCode(code: code, phone: phone);
  }
}
