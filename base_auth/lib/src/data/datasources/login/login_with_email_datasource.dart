import 'package:core/core.dart';

import '../../../domain/entities/login_email_entity.dart';
import '../../../infra/datasources/login/login_with_email_datasource.dart';

class LoginWithEmailDatasource extends ILoginWithEmailDatasource {
  final ILocalUserUsecase localUserUsecase;
  final IHttpDriver client;

  LoginWithEmailDatasource({
    required this.localUserUsecase,
    required this.client,
  });

  @override
  Future<Either<Exception, TokenEntity>> call({
    required LoginEmailEntity data,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await LoadJson.fromAsset('assets/mocks/user.json');
    return response.fold(
      (l) => Left(l),
      (r) async {
        try {
          final token = TokenModel.fromMap({'clienteId': r['wallet']['id']});
          final response = await localUserUsecase.setToken(token: token);
          return response.fold((l) => Left(l), (r) => Right(token));
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
