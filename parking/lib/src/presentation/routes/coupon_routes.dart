import 'package:core/core.dart';

import 'parking_routes.dart';

class CouponRoutes {
  static BasePath root = BasePath('/coupon/', ParkingRoutes.root);
  static BasePath couponSubmit = BasePath('/coupon_submit/', root);
  static BasePath couponsList = BasePath('/coupons_list/', root);
  static BasePath couponDetails = BasePath(
    '/coupons_details/',
    couponsList,
  );
  static BasePath couponSuccessfullyRegistered = BasePath(
    '/coupon_successfully_registered/',
    root,
  );
}
