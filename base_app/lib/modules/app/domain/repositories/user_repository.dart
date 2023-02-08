
import 'package:core/core.dart';

abstract class IUserRepository {
  Future<Either<Exception, UserEntity>> getUserById({required String id});
}
