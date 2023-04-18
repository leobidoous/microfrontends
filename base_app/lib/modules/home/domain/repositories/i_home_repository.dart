import 'package:core/core.dart';

abstract class IHomeRepository {
  Future<Either<Exception, Unit>> fecthNearbyShoppping();
}
