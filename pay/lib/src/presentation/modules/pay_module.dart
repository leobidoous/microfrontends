import 'package:core/core.dart';
import 'package:pay/src/presentation/modules/phone_recharge_module.dart';
import 'package:pay/src/presentation/pay_routes.dart';
import 'package:wallet/wallet.dart';

import '../controllers/pay_controller.dart';
import '../pages/pay_page.dart';

class PayModule extends Module {
  @override
  final List<Bind> binds = [
    /// Select payment method
    ...SelectPaymentMethodModule.exportedBinds,

    /// Controllers
    Bind.factory<PayController>(
      (i) => PayController(session: i.get<SessionEntity>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const PayPage(),
    ),
    ModuleRoute(PayRoutes.phoneRecharge.path, module: PhoneRechargeModule()),
  ];
}
