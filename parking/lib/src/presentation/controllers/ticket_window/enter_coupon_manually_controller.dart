import 'package:core/core.dart';

import '../../../domain/entities/ticket_window/unique_coupon_entity.dart';
import '../../../domain/usecases/ticket_window/i_ticket_window_usecase.dart';

class EnterCouponManuallyController
    extends GenController<List<Exception>, List<UniqueCouponEntity>> {
  EnterCouponManuallyController({required this.usecase}) : super(const []);

  final ITicketWindowUsecase usecase;

  void onAddValue(UniqueCouponEntity value) {
    final values = List<UniqueCouponEntity>.from(state, growable: true);
    values.insert(0, value);
    update(values);
  }

  void onUpdateCouponValue(double? value, UniqueCouponEntity coupon) {
    state[state.indexOf(coupon)].value = value;
    update(state, force: true);
  }

  bool get isValid {
    return state.isNotEmpty &&
        state.every((element) => element.value != null && element.value! > 0);
  }

  Future<void> uploadCoupons() async {
    await execute(
      () => usecase.uploadCoupon(coupons: state).then(
            (value) => value.fold(
              (l) {
                final errors = l.map((e) => Exception(e)).toList();
                return Left(errors);
              },
              (r) async {
                // TODO: remove timer
                await Future.delayed(const Duration(seconds: 3));
                return Right(state);
              },
            ),
          ),
    );
  }

  double get sum {
    double sum = 0;
    state.forEach((e) => sum += e.value ?? 0);
    return sum;
  }
}
