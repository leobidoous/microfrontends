import 'package:dartz/dartz.dart';

import '../../../../domain/entities/login/login_with_phone_entity.dart';
import '../../../../infra/datasources/login/local/local_login_with_phone_datasource.dart';

class LocalLoginWithPhoneDatasource extends ILocalLoginWithPhoneDatasource {
  @override
  Future<Either<Exception, Object>> call({required LoginWithPhoneEntity login,}) {
    // TODO: implement call
    throw UnimplementedError();
  }

}