import 'package:core/core.dart';

import '../repositories/user_repository.dart';

abstract class IUserUsecase {
  Future<Either<Exception, UserEntity>> getUserById({required String id});
}

class UserUsecase extends IUserUsecase {
  final IUserRepository repository;

  UserUsecase({required this.repository});

  @override
  Future<Either<Exception, UserEntity>> getUserById({required String id}) {
    return repository.getUserById(id: id);
  }
}
