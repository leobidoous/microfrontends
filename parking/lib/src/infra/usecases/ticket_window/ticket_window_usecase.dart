import 'package:core/core.dart';

import '../../../domain/entities/ticket_window/unique_coupon_entity.dart';
import '../../../domain/repositories/ticket_window/i_ticket_window_repository.dart';
import '../../../domain/usecases/ticket_window/i_ticket_window_usecase.dart';

class TicketWindowUsecase extends ITicketWindowUsecase {
  final ITicketWindowRepository repository;
  final SessionEntity session;

  TicketWindowUsecase({required this.repository, required this.session});

  @override
  Future<Either<Exception, Unit>> onOcrRecognizer() {
    return repository.onOcrRecognizer();
  }

  @override
  Future<Either<List<GraphQLResponseError>, Unit>> uploadCoupon({
    required List<UniqueCouponEntity> coupons,
  }) {
    return repository.uploadCoupon(
      coupons: coupons,
      customerId: session.customer.id,
    );
  }
}
