import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';

abstract class IUserRepository {
  Future<Either<Exception, UserEntity>> getUserById({required String id});
}
