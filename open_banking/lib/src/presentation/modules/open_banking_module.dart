import 'package:core/core.dart';
import '../pages/open_banking_page.dart';

class OpenBaningModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const OpenBankingPage(),
    ),
  ];
}
