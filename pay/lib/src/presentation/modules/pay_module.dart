import 'package:core/core.dart';
import 'package:wallet/wallet.dart' show SelectPaymentMethodModule;

import '../controllers/scan_qr_code_controller.dart';
import '../pages/payment/payment_page.dart';
import '../pages/scan_qr_code_page.dart';
import '../pay_routes.dart';
import 'phone_recharge_module.dart';

class PayModule extends Module {
  @override
  final List<Bind> binds = [
    /// Select payment method
    ...SelectPaymentMethodModule.exportedBinds,

    /// Controllers
    Bind.factory<CodeScanController>((i) => CodeScanController()),
    Bind.factory<ScanQrCodeController>(
      (i) => ScanQrCodeController(scanController: i.get<CodeScanController>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => PaymentPage(
        isLinkC: args.data['isLinkC'],
        goToParking: args.data['goToParking'],
      ),
    ),
    ChildRoute(
      PayRoutes.scanQrCode.path,
      transition: TransitionType.downToUp,
      child: (_, args) => const ScanQrCodePage(),
    ),
    ModuleRoute(PayRoutes.phoneRecharge.path, module: PhoneRechargeModule()),
  ];
}
