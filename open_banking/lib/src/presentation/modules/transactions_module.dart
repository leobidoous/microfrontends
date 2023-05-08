import 'package:core/core.dart';

import '../open_banking_routes.dart';
import '../pages/transaction/transaction_details.dart';
import '../pages/transaction/transaction_list.dart';

class TransactionModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const TransactionList(),
    ),
    ChildRoute(
      OpenBankingRoutes.transactionDetails.path,
      child: (_, args) => const TransactionDetails(),
    ),
  ];
}
