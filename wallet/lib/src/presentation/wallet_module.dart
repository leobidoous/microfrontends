import 'package:core/core.dart';

import '../data/datasources/get_transations_datasource.dart';
import '../domain/usecases/get_transactions_usecase.dart';
import '../infra/repositories/get_transactions_repository.dart';
import 'wallet_controller.dart';
import 'wallet_page.dart';

class WalletModule extends Module {
  @override
  final List<Bind> binds = [
    /// Login with email
    Bind.lazySingleton((i) => GetTransactionsDatasource()),
    Bind.lazySingleton(
      (i) => GetTransactionsRepository(
        datasource: DM.i.get<GetTransactionsDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetTransactionsUsecase(
        repository: DM.i.get<GetTransactionsRepository>(),
      ),
    ),

    /// Stores
    Bind.lazySingleton(
      (i) => WalletController(usecase: DM.i.get<GetTransactionsUsecase>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const WalletPage()),
  ];
}
