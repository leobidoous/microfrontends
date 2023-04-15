import 'package:core/core.dart';

import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../domain/entities/dashboard/tickets_history_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_request_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../../domain/repositories/parking/i_parking_repository.dart';
import '../../datasources/parking/i_parking_datasource.dart';

class ParkingRepository implements IParkingRepository {
  final IParkingDatasource datasource;

  ParkingRepository({required this.datasource});

  @override
  Future<Either<IParkingDashboardFailures, TicketEntity>> fecthInfoTicket({
    String? code,
    required String idShopping,
    required String customerId,
  }) async {
    return datasource.fecthInfoTicket(
      code: code,
      idShopping: idShopping,
      customerId: customerId,
    );
  }

  @override
  Future<Either<Exception, CouponEntity>> fetchCoupon({
    required String idShopping,
    required String customerId,
  }) async {
    return datasource.fetchCoupon(
      idShopping: idShopping,
      customerId: customerId,
    );
  }

  @override
  Future<Either<IParkingDashboardFailures, TicketPaymentEntity>> paymentTicket({
    required TicketPaymentRequestEntity paymentRequestEntity,
  }) async {
    return datasource.paymentTicket(paymentRequestEntity: paymentRequestEntity);
  }

  @override
  Future<Either<Exception, TicketsHistoryEntity>> fetchHistoryTicket({
    required String page,
    required String perPage,
  }) async {
    return datasource.fetchHistoryTicket(
      page: page,
      perPage: perPage,
    );
  }

  @override
  Future<Either<Exception, String>> fetchParkingRules({
    required String shoppingId,
  }) {
    return datasource.fetchParkingRules(shoppingId: shoppingId);
  }
}
