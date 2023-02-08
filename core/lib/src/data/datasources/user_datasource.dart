import 'package:dartz/dartz.dart';

import '../../domain/entities/user_entity.dart';
import '../../infra/datasources/user_datasource.dart';
import '../../infra/drivers/http_driver.dart';
import '../../infra/models/user_model.dart';

class UserDatasource extends IUserDatasource {
  final IHttpDriver client;

  UserDatasource({required this.client});

  @override
  Future<Either<Exception, UserEntity>> getUserById({
    required String id,
  }) async {
    final response = await client.get('/v1/cliente/$id');
    return response.fold(
      (l) => Left(Exception(l.statusMessage)),
      (r) async {
        try {
          final user = UserModel.fromMap(r.data['data']);
          return Right(user);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
