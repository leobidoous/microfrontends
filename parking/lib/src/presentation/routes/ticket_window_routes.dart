import 'package:core/core.dart';

import 'desk_routes.dart';

class TicketWindowRoutes {
  static const BasePath root = BasePath('/ticket_window/', DeskRoutes.root);
  static const BasePath takePhoto = BasePath('/take_picture/', root);
  static const BasePath reviewPhoto = BasePath('/review_photo/', takePhoto);
  static const BasePath reviewPhotoBeforeSubmit = BasePath(
    '/review_photo_before_submit/',
    reviewPhoto,
  );
  static const BasePath enterCouponManually = BasePath(
    '/enter_coupon_manually/',
    reviewPhotoBeforeSubmit,
  );
  static const BasePath couponOcrRecognized = BasePath(
    '/coupon_ocr_recognized/',
    reviewPhotoBeforeSubmit,
  );
  static const BasePath couponSubmissionResult = BasePath(
    '/coupon_submission_result/',
    reviewPhotoBeforeSubmit,
  );
  static const BasePath scanTicketOrEnterPlate = BasePath(
    '/scan_ticket_or_enter_plate/',
    couponSubmissionResult,
  );
}
