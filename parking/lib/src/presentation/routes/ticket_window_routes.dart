import 'package:core/core.dart';

import 'desk_routes.dart';

class TicketWindowRoutes {
  static const BasePath root = BasePath('/ticket_window/', DeskRoutes.root);
  static const BasePath takePhoto = BasePath('/take_picture/', root);
  static const BasePath reviewPhoto = BasePath('/review_photo/', root);
  static const BasePath reviewPhotoBeforeSubmit = BasePath(
    '/review_photo_before_submit/',
    root,
  );
  static const BasePath enterCouponManually = BasePath(
    '/enter_coupon_manually/',
    root,
  );
  static const BasePath couponOcrRecognized = BasePath(
    '/coupon_ocr_recognized/',
    root,
  );
  static const BasePath couponSubmissionResult = BasePath(
    '/coupon_submission_result/',
    root,
  );
  static const BasePath scanTicketOrEnterPlate = BasePath(
    '/scan_ticket_or_enter_plate/',
    root,
  );
}
