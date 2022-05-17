import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_email_entity.dart';
import '../../../../infra/datasources/login/remote/remote_login_with_email_datasource.dart';

class RemoteLoginWithEmailDatasource extends IRemoteLoginWithEmailDatasource {
  @override
  Future<Either<Exception, Object>> call({
    required LoginWithEmailEntity login,
  }) async {
    final response = await LoadMock.fromAsset('login_mock.json');
    
    if (response['response']['email'] == login.email) {
      return Right(response);
    } else {
      return Left(Exception('E-mail ou senha inválidos'));
    }
  }
}
