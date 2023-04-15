import 'package:core/core.dart';

import '../../../domain/entities/dashboard/coupon_entity.dart';
import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../domain/entities/dashboard/tickets_history_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_request_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../../domain/repositories/parking/i_parking_repository.dart';
import '../../../domain/usecases/parking/i_parking_usecase.dart';

class ParkingUsecase implements IParkingUsecase {
  final IParkingRepository repository;
  final SessionEntity session;

  ParkingUsecase({required this.repository, required this.session});

  @override
  Future<Either<IParkingDashboardFailures, TicketEntity>> fecthInfoTicket({
    String? code,
    required String idShopping,
  }) async {
    return repository.fecthInfoTicket(
      code: code,
      idShopping: idShopping,
      customerId: session.customer.id,
    );
  }

  @override
  Future<Either<Exception, CouponEntity>> fetchCoupon({
    required String idShopping,
  }) async {
    return repository.fetchCoupon(
      idShopping: idShopping,
      customerId: session.customer.id,
    );
  }

  @override
  Future<Either<IParkingDashboardFailures, TicketPaymentEntity>> paymentTicket({
    required TicketPaymentRequestEntity paymentRequestEntity,
  }) async {
    return repository.paymentTicket(paymentRequestEntity: paymentRequestEntity);
  }

  @override
  Future<Either<Exception, TicketsHistoryEntity>> fetchHistoryTicket({
    required String page,
    required String perPage,
  }) async {
    return repository.fetchHistoryTicket(
      page: page,
      perPage: perPage,
    );
  }

  @override
  Future<Either<Exception, String>> fetchParkingRules({
    required String shoppingId,
  }) {
    return repository.fetchParkingRules(shoppingId: shoppingId);
  }
}
