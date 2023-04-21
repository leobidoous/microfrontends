import 'package:core/core.dart';

import '../../../../domain/usecases/parking/i_parking_usecase.dart';
import '../../../../infra/models/ticket/history_ticket_model.dart';

class TicketHistoryController
    extends GenController<Exception, List<HistoryTicketModel>> {
  final IParkingUsecase usecase;

  TicketHistoryController({required this.usecase}) : super([]);

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
