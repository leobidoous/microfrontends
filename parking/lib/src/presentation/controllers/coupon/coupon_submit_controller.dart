import 'package:core/core.dart' hide UnknowError;
import 'package:wallet/wallet.dart';

import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../domain/failures/coupon/coupon_failure.dart';
import '../../../domain/usecases/coupon/i_coupon_usecase.dart';
import '../../../domain/usecases/parking/i_parking_usecase.dart';

class CouponSubmitController
    extends GenController<ICouponFailure, TransactionEntity> {
  final ICouponUsecase couponUsecase;
  final IParkingUsecase parkingUsecase;
  CouponEntity? coupon;

  CouponSubmitController({
    required this.couponUsecase,
    required this.parkingUsecase,
  }) : super(TransactionModel.fromMap({}));

  Future<void> onRegisterCoupon({
    required String qrcode,
    required String idShopping,
  }) async {
    await execute(
      () => couponUsecase.onRegisterCoupon(qrcode: qrcode).then((value) {
        return value.fold(
          (l) => Left(l),
          (transaction) async {
            final response = await parkingUsecase.fetchCoupon(
              idShopping: idShopping,
            );
            return response.fold(
              (l) => Left(UnknowError(l.toString())),
              (r) {
                coupon = r;
                update(transaction);
                return Right(transaction);
              },
            );
          },
        );
      }),
    );
  }
}
