import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_phone_entity.dart';
import '../../../../infra/datasources/login/remote/remote_login_with_phone_datasource.dart';

class RemoteLoginWithPhoneDatasource extends IRemoteLoginWithPhoneDatasource {
  final ILoggedUserDatasource loggedUserDatasource;

  RemoteLoginWithPhoneDatasource({required this.loggedUserDatasource});

  @override
  Future<Either<Exception, Object>> call({
    required LoginWithPhoneEntity login,
  }) async {
    final response = await LoadMock.fromAsset('login_mock.json');
    final user = LoggedUserModel.fromMap(response['response']);
    if (user.phone == login.phone) {
      return await loggedUserDatasource
          .saveLoggedUser(user: user)
          .then((value) {
        return value.fold(
          (l) => Left(Exception('Erro ao criar sessão do usuário')),
          (r) => Right(r),
        );
      });
    } else {
      return Left(Exception('Telefone ou senha inválidos'));
    }
  }
}
