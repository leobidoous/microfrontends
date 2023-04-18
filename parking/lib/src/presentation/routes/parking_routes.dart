import 'package:core/core.dart';

class ParkingRoutes {
  ParkingRoutes({required BasePath parent}) {
    _parent = parent;
  }
  
  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/parking/', _parent);
  static BasePath enterPlateNumber = BasePath(
    '/enter_plate_number/',
    root,
  );
  static BasePath regulation = BasePath('/regulation/', root);
  static BasePath historyPayment = BasePath('/history_payment/', root);
  static BasePath scanTicket = BasePath('/scan_ticket/', root);
  static BasePath parkingAmountInfo = BasePath(
    '/parking_amount_info/',
    root,
  );
  static BasePath enterTicketNumber = BasePath(
    '/enter_ticket_number/',
    root,
  );
}
