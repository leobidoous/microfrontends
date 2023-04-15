import 'package:core/core.dart';

import '../../../domain/entities/ticket_window/unique_coupon_entity.dart';

abstract class ITicketWindowDatasource {
  Future<Either<Exception, Unit>> onOcrRecognizer();
  Future<Either<List<GraphQLResponseError>, Unit>> uploadCoupon({
    required List<UniqueCouponEntity> coupons,
    required String customerId,
  });
}
