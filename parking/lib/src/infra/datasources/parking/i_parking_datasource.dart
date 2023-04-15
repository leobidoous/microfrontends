import 'package:core/core.dart';

import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../domain/entities/dashboard/tickets_history_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_request_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';

abstract class IParkingDatasource {
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

  Future<Either<Exception, TicketsHistoryEntity>> fetchHistoryTicket({
    required String page,
    required String perPage,
  });
  Future<Either<Exception, String>> fetchParkingRules({
    required String shoppingId,
  });
}
