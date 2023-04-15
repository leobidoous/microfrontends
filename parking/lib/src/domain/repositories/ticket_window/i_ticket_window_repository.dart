import 'package:core/core.dart';

import '../../entities/ticket_window/unique_coupon_entity.dart';

abstract class ITicketWindowRepository {
  Future<Either<Exception, Unit>> onOcrRecognizer();
  Future<Either<List<GraphQLResponseError>, Unit>> uploadCoupon({
    required List<UniqueCouponEntity> coupons,
    required String customerId,
  });
}
