import 'package:core/core.dart';

import '../../../domain/entities/ticket/ticket_payment_entity.dart';
import '../../../domain/entities/ticket/ticket_payment_request_entity.dart';
import '../../../domain/usecases/parking/i_parking_usecase.dart';
import '../../../infra/models/ticket/ticket_payment_model.dart';

class PaymentController extends GenController<Exception, TicketPaymentEntity> {
  final IParkingUsecase usecase;

  PaymentController({
    required this.usecase,
  }) : super(TicketPaymentModel.fromMap({}));

  Future<void> paymentTicket({
    required TicketPaymentRequestEntity paymentRequestEntity,
  }) async {
    await execute(
      () => usecase.paymentTicket(
        paymentRequestEntity: paymentRequestEntity,
      ),
    );
  }
}
