import 'package:core/core.dart';

import 'my_orders_page.dart';
import 'my_orders_store.dart';

class MyOrdersModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MyOrdersStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const MyOrdersPage()),
  ];
}
