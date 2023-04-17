import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../domain/failures/coupon/coupon_failure.dart';
import '../../../domain/repositories/coupon/i_coupon_repository.dart';
import '../../../domain/usecases/coupon/i_coupon_usecase.dart';

class CouponUsecase extends ICouponUsecase {
  final ICouponRepository repository;
  final SessionEntity session;

  CouponUsecase({required this.repository, required this.session});

  @override
  Future<Either<Exception, List<TransactionEntity>>> fetchCoupons() {
    return repository.fetchCoupons(
      marketplaceId: session.claims.marketplaceId,
      customerId: session.customer.id,
    );
  }

  @override
  Future<Either<ICouponFailure, TransactionEntity>> onRegisterCoupon({
    required String qrcode,
  }) {
    return repository.onRegisterCoupon(
      customerId: session.customer.id,
      qrcode: qrcode,
    );
  }

  @override
  Future<Either<Exception, Object>> onValidateCoupon() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> setParkingReleaseStatus({
    required DeskCardStatus status,
  }) {
    return repository.setParkingReleaseStatus(status: status);
  }
}
