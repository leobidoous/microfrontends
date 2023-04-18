import 'package:core/core.dart';

abstract class IHomeDatasource {
  Future<Either<Exception, Unit>> fecthNearbyShoppping();
}
