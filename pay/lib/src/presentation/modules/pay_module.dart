import 'package:core/core.dart';

import '../controllers/pay_controller.dart';
import '../pages/pay_page.dart';

class PayModule extends Module {
  @override
  final List<Bind> binds = [
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
  ];
}
