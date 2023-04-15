import 'package:core/core.dart';

import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../../domain/usecases/parking/i_parking_usecase.dart';
import '../../../infra/models/dashboard/ticket_model.dart';

class TicketSubmitController
    extends GenController<IParkingDashboardFailures, TicketEntity> {
  final IParkingUsecase usecase;

  TicketSubmitController({
    required this.usecase,
  }) : super(TicketModel.fromMap({}));

  Future<void> fetchTicketDetails({
    required String code,
    required String idShopping,
  }) async {
    await execute(
      () => usecase.fecthInfoTicket(code: code, idShopping: idShopping),
    );
  }
}
