import 'package:core/core.dart';

import 'parking_routes.dart';

class CouponRoutes {
  static const BasePath root = BasePath('/coupon/', ParkingRoutes.root);
  static const BasePath couponSubmit = BasePath('/coupon_submit/', root);
  static const BasePath couponsList = BasePath('/coupons_list/', root);
  static const BasePath couponDetails = BasePath(
    '/coupons_details/',
    couponsList,
  );
  static const BasePath couponSuccessfullyRegistered = BasePath(
    '/coupon_successfully_registered/',
    root,
  );
}
