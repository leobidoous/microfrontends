import 'package:core/core.dart';

import '../../../domain/usecases/parking/i_parking_usecase.dart';
import 'parking_coupon_controller.dart';
import 'parking_ticket_controller.dart';

class ParkingController extends GenController<Exception, Unit> {
  ParkingController({
    required this.usecase,
    required this.ticketController,
    required this.couponController,
  }) : super(unit);

  final IParkingUsecase usecase;
  final ParkingCouponController couponController;
  final ParkingTicketController ticketController;
}
