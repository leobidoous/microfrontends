import 'package:core/core.dart';

import 'parking_routes.dart';

class TicketRoutes {
  static const BasePath root = BasePath('/ticket/', ParkingRoutes.root);
  static const BasePath ticketVoucherDetails = BasePath(
    '/ticket_voucher_detaisl/',
    root,
  );
  static const BasePath ticketTracking = BasePath('/ticket_tracking/', root);
}
