import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../../domain/enums/desk_cart_status_enum.dart';

abstract class ICouponDatasource {
  Future<Either<Exception, List<TransactionEntity>>> fetchCoupons({
    required String customerId,
    required String marketplaceId,
  });
  Future<Either<CloudFunctionDriverResponse, TransactionEntity>>
      onRegisterCoupon({
    required String customerId,
    required String qrcode,
  });
  Future<Either<Exception, Object>> onValidateCoupon();
  Future<Either<Exception, Unit>> setParkingReleaseStatus({
    required DeskCardStatus status,
  });
}
