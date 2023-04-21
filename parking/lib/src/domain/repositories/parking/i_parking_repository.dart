import 'package:core/core.dart';

import '../../../infra/models/ticket/history_ticket_model.dart';
import '../../entities/dashboard/coupon_entity.dart';
import '../../entities/dashboard/ticket_entity.dart';
import '../../entities/ticket/ticket_payment_entity.dart';
import '../../entities/ticket/ticket_payment_request_entity.dart';
import '../../failures/dashboard/dashboard_failure.dart';

abstract class IParkingRepository {
  Future<Either<Exception, CouponEntity>> fetchCoupon({
    required String idShopping,
    required String customerId,
  });

  Future<Either<IParkingDashboardFailures, TicketEntity>> fecthInfoTicket({
    String? code,
    required String idShopping,
    required String customerId,
  });

  Future<Either<IParkingDashboardFailures, TicketPaymentEntity>> paymentTicket({
    required TicketPaymentRequestEntity paymentRequestEntity,
  });

  Future<Either<Exception, List<HistoryTicketModel>>> fetchHistoryTicket({
    required String page,
    required String perPage,
  });
  Future<Either<Exception, String>> fetchParkingRules({
    required String shoppingId,
  });
}
