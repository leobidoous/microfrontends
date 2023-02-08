import 'package:dartz/dartz.dart';

import '../../domain/entities/user_entity.dart';

abstract class IUserDatasource {
  Future<Either<Exception, UserEntity>> getUserById({required String id});
}
