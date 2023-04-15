import 'package:core/core.dart';

import '../../../domain/entities/dashboard/ticket_entity.dart';
import '../../../domain/failures/dashboard/dashboard_failure.dart';
import '../../../domain/usecases/parking/i_parking_usecase.dart';
import '../../../infra/models/dashboard/ticket_model.dart';

class ParkingTicketController
    extends GenController<IParkingDashboardFailures, TicketEntity> {
  ParkingTicketController({required this.usecase})
      : super(TicketModel.fromMap({}));
  final IParkingUsecase usecase;

  void fecthInfoTicket({required String idShopping}) {
    execute(() => usecase.fecthInfoTicket(idShopping: idShopping));
  }
}
