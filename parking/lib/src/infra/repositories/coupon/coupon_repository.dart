import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../domain/failures/coupon/coupon_failure.dart';
import '../../../domain/repositories/coupon/i_coupon_repository.dart';
import '../../datasources/coupon/i_coupon_datasource.dart';

class CouponRepository extends ICouponRepository {
  final ICouponDatasource datasource;

  CouponRepository({required this.datasource});

  @override
  Future<Either<Exception, List<TransactionEntity>>> fetchCoupons({
    required String customerId,
    required String marketplaceId,
  }) async {
    final response = await datasource.fetchCoupons(
      customerId: customerId,
      marketplaceId: marketplaceId,
    );
    return response.fold((l) => Left(l), (r) {
      final coupons = List<TransactionEntity>.empty(growable: true);
      r.forEach((coupon) {
        if (DateFormat.dateIsToday(coupon.insertedAt)) coupons.add(coupon);
      });
      coupons.sort((a, b) => b.insertedAt.compareTo(a.insertedAt));
      return Right(coupons);
    });
  }

  @override
  Future<Either<ICouponFailure, TransactionEntity>> onRegisterCoupon({
    required String customerId,
    required String qrcode,
  }) async {
    final response = await datasource.onRegisterCoupon(
      customerId: customerId,
      qrcode: qrcode,
    );
    return response.fold(
      (l) {
        switch (l.statusCode) {
          case 422:
            switch (l.data['body']['errors']['code']) {
              case 'TAX100':
                return Left(
                  KeyNotInformedError(
                    l.data['body']['errors']['code'],
                    detailsMessage: l.data['body']['errors']['message'],
                  ),
                );
              case 'TAX101':
                return Left(
                  InvalidCodeError(
                    l.data['body']['errors']['code'],
                    detailsMessage: l.data['body']['errors']['message'],
                  ),
                );
              case 'TAX102':
                return Left(
                  CouponAlreadyRegisteredError(
                    l.data['body']['errors']['code'],
                    detailsMessage: l.data['body']['errors']['message'],
                  ),
                );
              case 'TAX103':
                return Left(
                  PlaceNotFoundError(
                    l.data['body']['errors']['code'],
                    detailsMessage: l.data['body']['errors']['message'],
                  ),
                );
              case 'TAX104':
                return Left(
                  CouponQueryError(
                    l.data['body']['errors']['code'],
                    detailsMessage: l.data['body']['errors']['message'],
                  ),
                );
              default:
                return Left(
                  UnknowError(
                    l.data['body']['errors']['code'],
                    detailsMessage: l.data['body']['errors']['message'],
                  ),
                );
            }
          default:
            return Left(UnknowError(l.data.toString()));
        }
      },
      (r) => Right(r),
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
    return datasource.setParkingReleaseStatus(status: status);
  }
}
