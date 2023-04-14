import 'package:core/core.dart';

import '../../data/datasources/credit_card/credit_card_datasource.dart';
import '../../infra/repositories/credit_card/credit_card_repository.dart';
import '../../infra/usecases/credit_card/credit_card_usecase.dart';
import '../controllers/add_credit_card/add_credit_card_address_controller.dart';
import '../controllers/add_credit_card/add_credit_card_controller.dart';
import '../pages/add_credit_card/add_credit_card_page.dart';

class AddCreditCardModule extends Module {
  static List<Bind> get exportedBinds => [
        Bind.factory<CreditCardDatasource>(
          (i) => CreditCardDatasource(
            storageDriver: i.get<FirebaseStorageDriver>(),
            graphQlClient: i.get<GraphQlClientDriver>(),
          ),
        ),
        Bind.factory<CreditCardRepository>(
          (i) => CreditCardRepository(
            datasource: i.get<CreditCardDatasource>(),
          ),
        ),
        Bind.factory<CreditCardUsecase>(
          (i) => CreditCardUsecase(
            session: i.get<SessionEntity>(),
            repository: i.get<CreditCardRepository>(),
          ),
        ),
      ];

  @override
  final List<Bind> binds = [
    /// Controllers
    Bind.factory<AddCreditCardController>(
      (i) => AddCreditCardController(
        session: i.get<SessionEntity>(),
        usecase: i.get<CreditCardUsecase>(),
      ),
    ),
    Bind.factory<AddCreditCardAddressController>(
      (i) => AddCreditCardAddressController(
        usecase: i.get<SearchPostalCodeUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const AddCreditCardPage(),
    ),
  ];
}
