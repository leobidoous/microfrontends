import 'package:core/core.dart';

import 'cart_page.dart';
import 'cart_store.dart';

class CartModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CartStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const CartPage()),
  ];
}
