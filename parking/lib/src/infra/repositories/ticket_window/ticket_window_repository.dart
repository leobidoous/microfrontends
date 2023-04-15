import 'package:core/core.dart';

import '../../../domain/entities/ticket_window/unique_coupon_entity.dart';
import '../../../domain/repositories/ticket_window/i_ticket_window_repository.dart';
import '../../datasources/ticket_window/i_ticket_window_datasource.dart';

class TicketWindowRepository extends ITicketWindowRepository {
  final ITicketWindowDatasource datasource;

  TicketWindowRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> onOcrRecognizer() {
    return datasource.onOcrRecognizer();
  }

  @override
  Future<Either<List<GraphQLResponseError>, Unit>> uploadCoupon({
    required List<UniqueCouponEntity> coupons,
    required String customerId,
  }) {
    return datasource.uploadCoupon(coupons: coupons, customerId: customerId);
  }
}
