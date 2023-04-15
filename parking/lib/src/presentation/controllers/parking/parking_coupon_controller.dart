import 'package:core/core.dart';

import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../domain/usecases/parking/i_parking_usecase.dart';
import '../../../infra/models/dashboard/coupon_model.dart';

class ParkingCouponController extends GenController<Exception, CouponEntity> {
  final IParkingUsecase usecase;

  ParkingCouponController({required this.usecase})
      : super(CouponModel.fromMap({}));

  late String parkingRoleUrl;

  void fetchCoupon({required String idShopping}) {
    execute(
      () => usecase.fetchCoupon(idShopping: idShopping).then(
            (value) => value.fold((l) => Left(l), (coupon) async {
              return usecase.fetchParkingRules(shoppingId: idShopping).then(
                    (value) => value.fold((l) => Left(l), (url) {
                      parkingRoleUrl = url;
                      return Right(coupon);
                    }),
                  );
            }),
          ),
    );
  }
}
