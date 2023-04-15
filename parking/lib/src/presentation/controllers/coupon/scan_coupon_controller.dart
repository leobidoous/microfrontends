import 'dart:async';

import 'package:core/core.dart';

import '../../../domain/enums/desk_cart_status_enum.dart';
import '../../../domain/failures/coupon/coupon_failure.dart';
import '../../../domain/usecases/coupon/i_coupon_usecase.dart';

class ScanCouponController extends GenController<List<ICouponFailure>, String> {
  final QrCodeScanController scanController;
  final ICouponUsecase couponUsecase;
  late Timer timer;

  ScanCouponController({
    required this.scanController,
    required this.couponUsecase,
  }) : super('');

  void startTime(Function() callback) {
    timer = Timer(const Duration(seconds: 7), () async {
      await callback();
      startTime(callback);
    });
  }

  Future<void> onAddError(ICouponFailure failure) async {
    final errors = List<ICouponFailure>.from(error ?? [], growable: true);
    setError([...errors, failure]);
    if ((error?.length ?? 0) >= 3) {
      await couponUsecase.setParkingReleaseStatus(
        status: DeskCardStatus.pending,
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    scanController.dispose();
    super.dispose();
  }
}
