import 'package:core/core.dart';

import 'desk_routes.dart';

class TicketWindowRoutes {
  static BasePath root = BasePath('/ticket_window/', DeskRoutes.root);
  static BasePath takePicture = BasePath('/take_picture/', root);
  static BasePath reviewPhoto = BasePath('/review_photo/', root);
  static BasePath reviewPhotoBeforeSubmit = BasePath(
    '/review_photo_before_submit/',
    root,
  );
  static BasePath enterCouponManually = BasePath(
    '/enter_coupon_manually/',
    root,
  );
  static BasePath couponOcrRecognized = BasePath(
    '/coupon_ocr_recognized/',
    root,
  );
  static BasePath couponSubmissionResult = BasePath(
    '/coupon_submission_result/',
    root,
  );
  static BasePath scanTicketOrEnterPlate = BasePath(
    '/scan_ticket_or_enter_plate/',
    root,
  );
}
