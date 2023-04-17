import 'package:core/core.dart';

import '../controllers/phone_recharge/payment_method_controller.dart';
import '../controllers/phone_recharge/phone_recharge_controller.dart';
import '../pages/phone_recharge/phone_recharge_page.dart';

class PhoneRechargeModule extends Module {
  @override
  final List<Bind> binds = [
    /// Controllers
    Bind.factory<PaymentMethodController>((i) => PaymentMethodController()),
    Bind.factory<PhoneRechargeController>((i) => PhoneRechargeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const PhoneRechargePage(),
    ),
  ];
}
