import 'package:core/core.dart';

import '../../../domain/entities/ticket/ticket_payment_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_request_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../../domain/usecases/parking/i_parking_usecase.dart';
import '../../../infra/models/ticket/ticket_payment_model.dart';

class TicketPaymentController
    extends GenController<IParkingDashboardFailures, TicketPaymentEntity> {
  final IParkingUsecase usecase;

  TicketPaymentController({
    required this.usecase,
  }) : super(TicketPaymentModel.fromMap({}));

  Future<void> onPaymentTicket({
    required TicketPaymentRequestEntity paymentRequest,
  }) async {
    await execute(
      () => usecase.paymentTicket(paymentRequestEntity: paymentRequest),
    );
  }
}
