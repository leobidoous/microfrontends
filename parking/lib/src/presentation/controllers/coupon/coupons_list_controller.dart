import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../../domain/usecases/coupon/i_coupon_usecase.dart';

class CouponsListController
    extends GenController<Exception, List<TransactionEntity>> {
  final ICouponUsecase usecase;
  CouponsListController({required this.usecase}) : super(const []);

  void fetchCoupons() {
    execute(() => usecase.fetchCoupons());
  }
}
