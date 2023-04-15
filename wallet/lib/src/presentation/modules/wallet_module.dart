import 'package:core/core.dart';

import '../../../wallet.dart';
import '../../data/datasources/wallet/wallet_datasource.dart';
import '../../infra/repositories/wallet/wallet_repository.dart';
import '../../infra/usecases/credit_card/credit_card_usecase.dart';
import '../../infra/usecases/wallet/wallet_usecase.dart';
import '../controllers/credit_card/change_favorite_card_controller.dart';
import '../controllers/credit_card/remove_credit_card_controller.dart';
import '../pages/wallet/wallet_page.dart';
import 'add_credit_card_module.dart';

class WalletModule extends Module {
  static List<Bind> get exportedBinds => [
        /// Wallet
        Bind.factory<WalletDatasource>(
          (i) => WalletDatasource(
            storageDriver: i.get<FirebaseStorageDriver>(),
            graphQlClient: i.get<GraphQlClientDriver>(),
          ),
        ),
        Bind.factory<WalletRepository>(
          (i) => WalletRepository(datasource: i.get<WalletDatasource>()),
        ),
        Bind.factory<WalletUsecase>(
          (i) => WalletUsecase(
            session: i.get<SessionEntity>(),
            repository: i.get<WalletRepository>(),
          ),
        ),

        /// Controllers
        Bind.factory<FetchTransactionsController>(
          (i) => FetchTransactionsController(usecase: i.get<WalletUsecase>()),
        ),
      ];

  @override
  final List<Bind> binds = [
    /// Credit card
    ...AddCreditCardModule.exportedBinds,

    ///  Wallet
    ...exportedBinds,

    /// Controllers
    Bind.factory<FetchCreditCardsController>(
      (i) => FetchCreditCardsController(usecase: i.get<CreditCardUsecase>()),
    ),
    Bind.factory<ChangeFavoriteCardController>(
      (i) => ChangeFavoriteCardController(
        usecase: i.get<CreditCardUsecase>(),
        session: i.get<SessionEntity>(),
      ),
    ),
    Bind.factory<RemoveCreditCardController>(
      (i) => RemoveCreditCardController(usecase: i.get<CreditCardUsecase>()),
    ),
    Bind.factory<FetchFavoriteCreditCardsController>(
      (i) => FetchFavoriteCreditCardsController(
        usecase: i.get<CreditCardUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      transition: TransitionType.defaultTransition,
      child: (_, args) => const WalletPage(),
    ),
    ModuleRoute(
      WalletRoutes.selectPaymentMethod.path,
      transition: TransitionType.defaultTransition,
      module: SelectPaymentMethodModule(),
    ),
    ModuleRoute(
      WalletRoutes.addCreditCard.path,
      transition: TransitionType.defaultTransition,
      module: AddCreditCardModule(),
    ),
  ];
}
