import 'package:core/core.dart';

class ParkingRoutes {
  static const BasePath root = BasePath('/parking/');
  static const BasePath enterPlateNumber = BasePath(
    '/enter_plate_number/',
    root,
  );
  static const BasePath regulation = BasePath('/regulation/', root);
  static const BasePath historyPayment = BasePath('/history_payment/', root);
  static const BasePath scanTicket = BasePath('/scan_ticket/', root);
  static const BasePath parkingAmountInfo = BasePath(
    '/parking_amount_info/',
    root,
  );
  static const BasePath enterTicketNumber = BasePath(
    '/enter_ticket_number/',
    root,
  );
}
