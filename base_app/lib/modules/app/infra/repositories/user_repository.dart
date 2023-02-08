import 'package:core/core.dart';

import '../../domain/repositories/user_repository.dart';
import '../datasources/user_datasource.dart';

class UserRepository extends IUserRepository {
  final IUserDatasource datasource;

  UserRepository({required this.datasource});

  @override
  Future<Either<Exception, UserEntity>> getUserById({required String id}) {
    return datasource.getUserById(id: id);
  }
}
