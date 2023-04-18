import 'package:core/core.dart';

abstract class IHomeUsecase {
  Future<Either<Exception, Unit>> fecthNearbyShoppping();
}
