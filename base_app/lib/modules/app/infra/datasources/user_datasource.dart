import 'package:core/core.dart';


abstract class IUserDatasource {
  Future<Either<Exception, UserEntity>> getUserById({required String id});
}
