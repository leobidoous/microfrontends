import 'package:core/core.dart';

import 'parking_routes.dart';

class TicketRoutes {
  static  BasePath root = BasePath('/ticket/', ParkingRoutes.root);
  static  BasePath ticketVoucherDetails = BasePath(
    '/ticket_voucher_detaisl/',
    root,
  );
  static  BasePath ticketTracking = BasePath('/ticket_tracking/', root);
}
