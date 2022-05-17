import 'package:dartz/dartz.dart';

import '../../../../domain/entities/login/login_with_email_entity.dart';
import '../../../../infra/datasources/login/local/local_login_with_email_datasource.dart';

class LocalLoginWithEmailDatasource extends ILocalLoginWithEmailDatasource {
  @override
  Future<Either<Exception, Object>> call({
    required LoginWithEmailEntity login,
  }) {
    throw UnimplementedError();
  }
}
