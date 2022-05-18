import 'package:core/core.dart';

import '../../../../domain/entities/login/login_with_email_entity.dart';
import '../../../../infra/datasources/login/remote/remote_login_with_email_datasource.dart';

class RemoteLoginWithEmailDatasource extends IRemoteLoginWithEmailDatasource {
  final ILoggedUserDatasource loggedUserDatasource;

  RemoteLoginWithEmailDatasource({required this.loggedUserDatasource});

  @override
  Future<Either<Exception, Object>> call({
    required LoginWithEmailEntity login,
  }) async {
    final response = await LoadMock.fromAsset('login_mock.json');
    final user = LoggedUserModel.fromMap(response['response']);
    if (user.email == login.email) {
      return await loggedUserDatasource
          .saveLoggedUser(user: user)
          .then((value) {
        return value.fold(
          (l) => Left(Exception('Erro ao criar sessão do usuário')),
          (r) => Right(r),
        );
      });
    } else {
      return Left(Exception('E-mail ou senha inválidos'));
    }
  }
}
