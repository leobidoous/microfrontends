import 'package:core/core.dart';
import '../../../domain/entities/login_email_entity.dart';
import '../../../infra/datasources/login/login_with_email_datasource.dart';
import '../../../infra/models/login_email_model.dart';

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
    final response = await client.post(
      '/v1/login',
      data: LoginEmailModel.fromEntity(data).toMap,
    );
    return response.fold(
      (l) => Left(Exception(l.statusMessage)),
      (r) async {
        try {
          final token = TokenModel.fromMap(r.data['data']);
          final response = await localUserUsecase.setToken(token: token);
          return response.fold((l) => Left(l), (r) => Right(token));
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
