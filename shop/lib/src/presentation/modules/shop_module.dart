import 'package:core/core.dart';

import '../controllers/shop_controller.dart';
import '../pages/shop_page.dart';

class ShopModule extends Module {
  @override
  final List<Bind> binds = [
    /// Controllers
    Bind.factory<ShopController>(
      (i) => ShopController(session: i.get<SessionEntity>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ShopPage(),
    ),
  ];
}
