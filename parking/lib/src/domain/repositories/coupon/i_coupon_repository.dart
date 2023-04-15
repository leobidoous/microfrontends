import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../enums/desk_cart_status_enum.dart';
import '../../failures/coupon/coupon_failure.dart';

abstract class ICouponRepository {
  Future<Either<Exception, List<TransactionEntity>>> fetchCoupons({
    required String customerId,
    required String marketplaceId,
  });
  Future<Either<ICouponFailure, TransactionEntity>> onRegisterCoupon({
    required String customerId,
    required String qrcode,
  });
  Future<Either<Exception, Object>> onValidateCoupon();
   Future<Either<Exception, Unit>> setParkingReleaseStatus({
    required DeskCardStatus status,
    required String customerId,
    required String marketplaceId,
  });
}
