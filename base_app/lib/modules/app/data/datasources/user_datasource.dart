import 'package:core/core.dart';

import '../../infra/datasources/user_datasource.dart';

class UserDatasource extends IUserDatasource {
  final IHttpDriver client;

  UserDatasource({required this.client});

  @override
  Future<Either<Exception, UserEntity>> getUserById({
    required String id,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await LoadJson.fromAsset('assets/mocks/user.json');
    return response.fold(
      (l) => Left(l),
      (r) async {
        try {
          final user = UserModel.fromMap(
            {
              'id': r['wallet']['id'],
              'email': r['email'],
              'nome': r['name'],
            },
          );
          return Right(user);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
