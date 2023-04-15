import 'package:core/core.dart';


class ParkingRoutes {
  static const BasePath root = BasePath('/parking/');
  static const BasePath addTicketByPlate = BasePath(
    '/enter_ticket_board/',
    root,
  );
  static const BasePath regulation = BasePath('/regulation/', root);
  static const BasePath historyPayment = BasePath('/history_payment/', root);
  static const BasePath parkingAmountInfo = BasePath(
    '/parking_amount_info/',
    root,
  );
}
