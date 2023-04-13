import 'package:core/core.dart';

import '../../domain/failures/login/login_failure.dart';
import '../../domain/repositories/i_login_repository.dart';
import '../datasources/i_login_datasource.dart';

class LoginRepository extends ILoginRepository {
  final ILoginDatasource datasource;

  LoginRepository({required this.datasource});

  @override
  Future<Either<ILoginFailure, Unit>> onRequestCode({required String phone}) {
    return datasource.onRequestCode(phone: phone);
  }

  @override
  Future<Either<ILoginFailure, TokenEntity>> onValidateCode({
    required String phone,
    required String code,
  }) {
    return datasource.onValidateCode(code: code, phone: phone);
  }
}
