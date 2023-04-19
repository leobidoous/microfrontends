import 'package:core/core.dart';

import '../../../../domain/entities/dashboard/tickets_history_entity.dart';
import '../../../../domain/usecases/parking/i_parking_usecase.dart';
import '../../../../infra/models/dashboard/tickets_history_model.dart';

class TicketHistoryController
    extends GenController<Exception, TicketsHistoryEntity> {
  final IParkingUsecase usecase;

  TicketHistoryController({required this.usecase})
      : super(TicketsHistoryModel.fromMap({}));

  Future<void> fetchTicketHistory({
    required String page,
    required String perPage,
  }) async {
    await execute(
      () => usecase.fetchHistoryTicket(
        page: page,
        perPage: '100',
      ),
    );
  }
}
