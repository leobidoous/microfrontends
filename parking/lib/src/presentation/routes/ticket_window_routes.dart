import 'package:core/core.dart';

import 'desk_routes.dart';

class TicketWindowRoutes {
  static BasePath root = BasePath('/ticket_window/', DeskRoutes.root);
  static BasePath takePhoto = BasePath('/take_picture/', root);
  static BasePath reviewPhoto = BasePath('/review_photo/', takePhoto);
  static BasePath reviewPhotoBeforeSubmit = BasePath(
    '/review_photo_before_submit/',
    reviewPhoto,
  );
  static BasePath enterCouponManually = BasePath(
    '/enter_coupon_manually/',
    reviewPhotoBeforeSubmit,
  );
  static BasePath couponOcrRecognized = BasePath(
    '/coupon_ocr_recognized/',
    reviewPhotoBeforeSubmit,
  );
  static BasePath couponSubmissionResult = BasePath(
    '/coupon_submission_result/',
    reviewPhotoBeforeSubmit,
  );
  static BasePath scanTicketOrEnterPlate = BasePath(
    '/scan_ticket_or_enter_plate/',
    couponSubmissionResult,
  );
}
